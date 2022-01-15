//
//  readLocalFile.swift
//  Diffable
//
//  Created by Wonseok Lee on 2022/01/15.
//

import Foundation
import Then

func readLocalFile(forName name: String) -> Data? {
    do {
        if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
           let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
            return jsonData
        }
    } catch {
        print(error)
    }
    
    return nil
}

func parse(jsonData: Data) -> [Transaction] {
    do {
        let decodedData = try JSONDecoder().decode(Transaction_Arr.self, from: jsonData)
        return decodedData.transaction
    } catch {
        print("decode error")
    }
    
    preconditionFailure()
}
