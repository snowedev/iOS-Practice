//
//  NetworkResult.swift
//  CommonlyUsedStorage
//
//  Created by Wonseok Lee on 2021/06/14.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case failure(Int)
}

