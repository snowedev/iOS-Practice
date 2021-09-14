//
//  ImageCacheManager.swift
//  URLSession+Caching
//
//  Created by Wonseok Lee on 2021/09/14.
//

import UIKit

class ImageCacheManager {
    //    키값으로 쓸타입과 캐시에 넣을 타입을 정해주면된다.
    //    저는 URL String을 키값으로 구분하고 image를 넣어줄거에요
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
