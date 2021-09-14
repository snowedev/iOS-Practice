//
//  CAFETIService.swift
//  URLSession+Caching
//
//  Created by Wonseok Lee on 2021/09/13.
//

import Foundation

struct CAFETIService {
    static let shared = CAFETIService()
    
    // MARK: - baseURL + path
    let baseURL = "http://3.37.75.200:5000/"
    var urlString: String { get { baseURL + "cafeti" } }
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2MGU2OWUwZGNlN2Q0M2M3MzNlZTI2MTkiLCJpYXQiOjE2MzE1NDMyOTQsImV4cCI6MTYzMjQwNzI5NH0.SXls1ge8SMULxBbLKp5bFLGWiQJQw9pwx-i_GQ5aCv8"
    
    func fetchCAFETIData(answers: [Int], completion: @escaping (NetworkResult<CAFETI>) -> ()) {
        if let url = URL(string: urlString) {
            // MARK: 1.URLSessionConfiguration을 설정하고, Session을 생성합니다.
            let session = URLSession(configuration: .default)
            
            // MARK: 2.통신할 URL과 Request 객체를 준비합니다.
            var requestURL = URLRequest(url: url)
            requestURL.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            requestURL.setValue(token, forHTTPHeaderField: "token")
            requestURL.httpMethod = "POST"
            
            let body = ["answers": answers]
            guard let bodyData = try? JSONSerialization.data(withJSONObject: body, options: []) else { return }
            requestURL.httpBody = bodyData
            
            // MARK: 3.사용할 Task 를 결정하고, 그에 맞는 Completion Handler, 혹은 Delegate 메소드를 작성합니다.
            let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let bindingData = data {
                    do {
                        let decodedData = try JSONDecoder().decode(CAFETI.self, from: bindingData)
                        // MARK: 5.Task 완료 후 Completion Handler를 실행합니다.
                        completion(.success(decodedData))
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            // MARK: 4.Task를 실행합니다.
            dataTask.resume()
        }
    }
}
