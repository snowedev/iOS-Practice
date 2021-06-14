//
//  GenericResponse.swift
//  CommonlyUsedStorage
//
//  Created by Wonseok Lee on 2021/06/14.
//

import Foundation

struct GenericResponse<T: Codable>: Codable {
    
    let status: Int
    let success: String
    let message: String
    let data: T?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(Int.self, forKey: .status)) ?? -1
        success = (try? values.decode(String.self, forKey: .success)) ?? ""
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(T.self, forKey: .data)) ?? nil
    }
    
}

