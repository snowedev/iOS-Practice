//
//  CAFETIService.swift
//  URLSession+Caching
//
//  Created by Wonseok Lee on 2021/09/13.
//

import Foundation

struct CAFETIService {
    static let shared = CAFETIService()
    
    // MARK: - baseURL + apiKey
    let baseURL = "http://3.37.75.200:5000/"
    var urlString: String { get { baseURL + "cafeti" } }
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2MGU2OWUwZGNlN2Q0M2M3MzNlZTI2MTkiLCJpYXQiOjE2MzE1NDMyOTQsImV4cCI6MTYzMjQwNzI5NH0.SXls1ge8SMULxBbLKp5bFLGWiQJQw9pwx-i_GQ5aCv8"
    
    func fetchCAFETIData(answers: [Int], completion: @escaping (NetworkResult<CAFETI>) -> ()) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            var requestURL = URLRequest(url: url)
            requestURL.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            requestURL.setValue(token, forHTTPHeaderField: "token")
            requestURL.httpMethod = "POST"
            
            let body = ["answers": answers]
            guard let bodyData = try? JSONSerialization.data(withJSONObject: body, options: []) else {
                   return
            }
            requestURL.httpBody = bodyData
            
            let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let bindingData = data {
                    do {
                        let decodedData = try JSONDecoder().decode(CAFETI.self, from: bindingData)
                        completion(.success(decodedData))
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            dataTask.resume()
        }
    }
}
