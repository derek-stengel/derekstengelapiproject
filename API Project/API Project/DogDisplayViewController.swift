//
//  ViewController.swift
//  API Project
//
//  Created by Derek Stengel on 4/30/24.
//

import UIKit

class DogDisplayViewController: UIViewController {

    @IBOutlet var dogImage: UIImageView!
    @IBOutlet var newDogButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRandomDogImage()
    }
    
    func fetchRandomDogImage() {
        let dogAPIURL = URL(string: "https://dog.ceo/api/breeds/image/random")!
        
        URLSession.shared.dataTask(with: dogAPIURL) { data, response, error in
            if let error = error {
                print("Error fetching dog image: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data recieved from the API.")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                if let imageURLString = json["message"] as? String, let imageURL = URL(string: imageURLString) {
                    self.downloadDogImage(from: imageURL)
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        } .resume()
    }
    
    func downloadDogImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading dog image: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No daat found for dog image")
                return
            }
            
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.dogImage.image = image
                }
            }
        } .resume()
    }

    @IBAction func newDogButtonAction(_ sender: Any) {
        fetchRandomDogImage()
    }
    

}

