//
//  ApiCaller.swift
//  inpostSwift
//
//  Created by Oskar Figiel on 12/07/2020.
//

import Foundation

class ApiCaller {
    func getData(trackingNumber: String, completion: @escaping (ParcelModel) -> ()) {
        let urlBase = "https://api-shipx-pl.easypack24.net/v1/tracking/"
        let url = URL(string: urlBase + trackingNumber)
        let request = URLRequest(url: url!)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("responseCode: \(response.statusCode)")
                }
                if let data = data {
                    print(String(decoding: data, as:UTF8.self))
                    do {
                        let model = try JSONDecoder().decode(ParcelModel.self, from: data)
                        completion(model)
                    } catch let jsonErr {
                        print("failed to decode, \(jsonErr)")
                    }
                    
                }
            }
        }
        dataTask.resume()
    }
}


