//
//  ViewController.swift
//  WeatherApp
//
//  Created by Andrey Grach on 06.11.2019.
//  Copyright © 2019 Andrey Grach. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let urlString = "http://api.weatherstack.com/current?access_key=92c571f4c57def8fda0f07cc68bffe06&query=\(searchBar.text!)"
        let url = URL(string: urlString)
        
//        var locationName: String?
        var temperature: Double?
        
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    as! [String : AnyObject]
                
//                if let location = json["location"] {
//                    locationName = location["name"] as? String
//                }
    
                if let current = json["current"] {
                    temperature = current["temperature"] as? Double
                }
                
                
            DispatchQueue.main.async {
//                self.cityLabel.text = locationName
                self.temperatureLabel.text = "\(temperature!)"
            }
            }
                catch let jsonError {
                    print(jsonError)
            }
    
        }
         task.resume()
        }
        
    
}


