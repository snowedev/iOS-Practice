//
//  Transaction_Model.swift
//  Diffable
//
//  Created by Wonseok Lee on 2022/01/15.
//
import Foundation

// MARK: - Transaction_Arr
struct Transaction_Arr: Hashable,Codable {
    let transaction: [Transaction]
}

// MARK: - Transaction
struct Transaction: Hashable, Codable {
    let date, time: Int
    let gist: String
    let ipji, money: Int
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case date = "TRX_OPRT_DT"
        case time = "TRX_OPRT_TIME"
        case gist = "BBK_HNG_JKYO"
        case ipji = "IPJI_G"
        case money = "TRAMT"
        case title = "TRX_CMMT_CTNT"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = (try? container.decodeIfPresent(Int.self, forKey: .date)) ?? 0
        self.time = (try? container.decodeIfPresent(Int.self, forKey: .time)) ?? 0
        self.gist = (try? container.decodeIfPresent(String.self, forKey: .gist)) ?? "-"
        self.ipji = (try? container.decodeIfPresent(Int.self, forKey: .ipji)) ?? 99
        self.money = (try? container.decodeIfPresent(Int.self, forKey: .money)) ?? 0
        self.title = (try? container.decodeIfPresent(String.self, forKey: .title)) ?? "-"
    }
}
