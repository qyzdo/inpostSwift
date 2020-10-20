//
//  ApiCaller.swift
//  inpostSwift
//
//  Created by Oskar Figiel on 12/07/2020.
//

import Foundation

enum NetworkError: Int, Error {
    case badRequest = 400
    case notFound = 404
    case error
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badRequest:
            return NSLocalizedString("Błąd przesyłki, sprawdź numer i spróbuj ponownie.", comment: "Bad request")
        case .notFound:
            return NSLocalizedString("Nie znaleziono przesyłki, spróbuj ponownie.", comment: "Bad request")
        case .error:
            return NSLocalizedString("Wystąpił nieznany błąd, spróbuj ponownie.", comment: "Bad request")
            
        }
    }
}

class ApiCaller {
    func getData(trackingNumber: String, completion: @escaping (Result<ParcelModel, NetworkError>) -> Void) {
        let urlBase = "https://api-shipx-pl.easypack24.net/v1/tracking/"
        let url = URL(string: urlBase + trackingNumber)
        let request = URLRequest(url: url!)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(NetworkError.badRequest))
            } else {
                if let response = response as? HTTPURLResponse {
                    print(response.statusCode)
                    let responseCode = response.statusCode
                    if !(200 ... 299 ~= responseCode) {
                        if let error = NetworkError.init(rawValue: responseCode) {
                            completion(.failure(error))
                        }
                    }
                    else {
                        if let data = data {
                            do {
                                let model = try JSONDecoder().decode(ParcelModel.self, from: data)
                                completion(.success(model))
                            } catch let jsonErr {
                                print("failed to decode, \(jsonErr)")
                            }
                        }
                    }
                }
                
            }
        }
        dataTask.resume()
    }
}


