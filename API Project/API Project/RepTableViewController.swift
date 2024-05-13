//
//  RepTableViewController.swift
//  API Project
//
//  Created by Derek Stengel on 4/30/24.
//

import UIKit

struct RepresentativesResponse: Decodable {
    let results: [Representatives]
}

enum RepControllerError: Error, LocalizedError {
    case repNotFound
}

class RepTableViewController: UITableViewController {
    
    var reps: [Representatives] = []
    var filteredReps: [Representatives] = []
    
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func fetchMatchingReps() {
        self.reps = []
        self.tableView.reloadData()
        let zipCode = searchBar.text ?? ""
        if !zipCode.isEmpty {
            let queryItems = ["zip": zipCode]
            Task {
                do {
                    let repsInZipCode = try await fetchRepresentatives(query: queryItems)
                    reps = repsInZipCode
                    tableView.reloadData()
                }
                catch {
                    print(error)
                }
            }
        }
    }
    
    func fetchRepresentatives(query: [String: String] ) async throws -> [Representatives] {
        var urlComponents = URLComponents(string: "https://whoismyrepresentative.com/getall_mems.php")!
        urlComponents.queryItems = query.map {
            URLQueryItem(name: $0.key, value: $0.value) }
        urlComponents.queryItems?.append(URLQueryItem(name: "output", value: "json"))
        
        let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw RepControllerError.repNotFound }
        
        let searchResponse = try JSONDecoder().decode(RepresentativesResponse.self, from: data)
        return searchResponse.results
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reps.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepCell", for: indexPath) as! RepTableViewCell
        
        let representative = reps[indexPath.row]
        cell.repNameLabel.text = representative.repName
        cell.repStateLabel.text = representative.repState
        cell.repLinkLabel.text = representative.repLink

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension RepTableViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchMatchingReps()
    }
}
