//
//  TestTableViewController.swift
//  API Project
//
//  Created by Derek Stengel on 5/3/24.
//

//import UIKit
//
//struct RepresentativesResponse: Decodable {
//    let results: [Representatives]
//}
//
//class RepTableViewController: UITableViewController, UISearchBarDelegate {
//    
//    var reps: [Representatives] = []
//    var filteredReps: [Representatives] = []
//    
//    @IBOutlet var searchBar: UISearchBar!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        searchBar.delegate = self
//        
//        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
//            navigationItem.rightBarButtonItem = searchButton
//            
//        fetchRepresentatives()
//    }
//    
//    func fetchRepresentatives() {
//        let urlString = "https://whoismyrepresentative.com/getall_mems.php?zip=84005&output=json"
//        guard let url = URL(string: urlString) else {
//            print("Invalid URL")
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                print("Error: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//            
//            do {
//                
//                let jsonString = String(data: data, encoding: .utf8)
//                            print("Raw JSON Data: \(jsonString)")
//                
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(RepresentativesResponse.self, from: data)
//                self.reps = response.results
//                
//                print("Decoded Reps: \(self.reps)")
//                
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            } catch {
//                print("Error decoding JSON: \(error.localizedDescription)")
//            }
//        }.resume()
//    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return reps.count
//    }
//
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "RepCell", for: indexPath) as! RepTableViewCell
//        
//        let representative = reps[indexPath.row]
//        cell.repNameLabel.text = representative.repName
//        cell.repStateLabel.text = representative.repState
//        cell.repLinkLabel.text = representative.repLink
//
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
//    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//            filteredReps = reps.filter {
//                $0.repName.lowercased().contains(searchText.lowercased())
//            }
//            tableView.reloadData()
//        }
//    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//            searchBar.resignFirstResponder()
//        }
//        
//        // MARK: - Actions
//        
//        @objc func searchButtonTapped() {
//            searchBar.becomeFirstResponder()
//        }
//    
//    
//
//    /*
//    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//    */
//
//    /*
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
//    */
//
//    /*
//    // Override to support rearranging the table view.
//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//
//    }
//    */
//
//    /*
//    // Override to support conditional rearranging of the table view.
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the item to be re-orderable.
//        return true
//    }
//    */
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
