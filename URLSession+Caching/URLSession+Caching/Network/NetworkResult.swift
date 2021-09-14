//
//  NetworkResult.swift
//  URLSession+Caching
//
//  Created by Wonseok Lee on 2021/09/13.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
