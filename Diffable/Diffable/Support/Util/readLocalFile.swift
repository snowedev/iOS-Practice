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

func parse(jsonData: Data) -> [(Int, [Transaction])] {
    do {
        let decodedData = try JSONDecoder().decode(Transaction_Arr.self, from: jsonData)
        var transactionDictionary = [Int : [Transaction]]()
        for d in decodedData.transaction {
            if var data = transactionDictionary[d.date] {
                data.append(d)
                transactionDictionary[d.date] = data
            } else {
                transactionDictionary[d.date] = [d]
            }
        }
        return transactionDictionary.sorted { $0.key > $1.key }
    } catch {
        print("decode error")
    }
    
    preconditionFailure()
}

//func requestAdditionalData(data: [(Int, [Transaction])], page: Int) -> [(Int, [Transaction])] {
//    if data.count >= page * 10 {
//        return data[]
//    }
//}
