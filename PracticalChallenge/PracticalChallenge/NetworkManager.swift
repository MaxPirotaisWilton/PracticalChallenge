//
//  NetworkManager.swift
//  PracticalChallenge
//
//  Created by Max Pirotais-Wilton on 10/08/22.
//

import Foundation
import UIKit

class NetworkManager{
    
    var domainUrlString : String = "https://randomuser.me/"
    var isPaginating: Bool = false
    
    func callAPI(number: Int, pagination: Bool, completionHandler: @escaping ([Result]) -> Void){
        guard let url = URL(string: domainUrlString + "api/?results=" + String(number)) else{
            return
        }
        
        if pagination {
            isPaginating = true
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching films: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(response)")
                return
            }
            
            if let data = data,
               let people = try? JSONDecoder().decode(PersonModel.self, from: data) {
                completionHandler(people.results)
            }
            
            if pagination {
                self.isPaginating = false
            }
                })
        task.resume()
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
