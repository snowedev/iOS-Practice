//
//  UIImageView+.swift
//  URLSession+Caching
//
//  Created by Wonseok Lee on 2021/09/14.
//

import UIKit

/**
 우선 캐시처리에 대한 구현은 3번의 분기를 해야 한다고 생각해요
 
 1. 이미지가 memory cache(NSCache)에 있는지 확인하고
 - 원하는 이미지가 없다면
 
 2. disk cache(UserDefault 혹은 기기Directory에있는 file형태)에서 확인하고
 - 있다면 memory cache에 추가해주고 다음에는 더 빨리 가져 올수 있도록 할 수 있어요
 - 이마저도 없다면
 
 3. 서버통신을 통해서 받은 URL로 이미지를 가져와야해요
 - 이때 서버통신을 통해서 이미지를 가져왔으면 memory와 disk cache에 저장해줘야 캐시처리가 되겠죠?!
 
 */
extension UIImageView {
    /// No ImageCaching
    func setImageUrlWithNoCaching(_ url: String) {
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: url) {
                URLSession.shared.dataTask(with: url) { (data, res, err) in
                    if let _ = err {
                        DispatchQueue.main.async {
                            self.image = UIImage()
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        if let data = data, let image = UIImage(data: data) {
                            self.image = image
                        }
                    }
                }.resume()
            }
        }
    }
    
    /// with ImageCaching
    func setImageUrl(_ url: String) {
        
        // 캐시에 사용될 Key 값
        // 이미지url의 lastPathComponent를 찍으면 url에서 딱 파일명만 가져올 수 있어요
        // www.abcd.com/image/test.jpg라면 test.jpg만 딱 가지고 올수 있는거에요
        let cacheKey = NSString(string: url).lastPathComponent
        
        // MARK: Memory Cache
        // 1. 이미지가 memory cache(NSCache)에 있는지 확인하고
        // 불러오려는 이미지가 이미 메모리 캐시에 저장되어 있으면 캐싱된 이미지를 사용
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey as NSString) {
            DispatchQueue.main.sync {
                print("CACHE>> Load Memory cache")
                self.image = cachedImage
            }
            return
        }
        
        // 메모리 캐시에 원하는 이미지가 없다면
        
        // MARK: Disk Cache
        // 2. disk cache(UserDefault 혹은 기기Directory에있는 file형태)에서 확인하고
        // 있다면 memory cache에 추가해주고 다음에는 더 빨리 가져 올수 있도록 할 수 있음
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else { return }
        print(path)
        let filePath = URL(fileURLWithPath: path).appendingPathComponent(cacheKey)
        let fileManager = FileManager()
        
        if fileManager.fileExists(atPath: filePath.path) {
            guard let imageData = try? Data(contentsOf: filePath) else {
                print("disk cache image data nil")
                return
            }
            
            guard let cachedImage = UIImage(data: imageData) else {
                print("disk cache image data nil")
                return
            }
            
            DispatchQueue.main.sync {
                print("CACHE>> Load Disk cache")
                ImageCacheManager.shared.setObject(cachedImage, forKey: cacheKey as NSString)
                self.image = cachedImage
            }
            return
        }
        
        // 이마저도 없다면
        // 3. 서버통신을 통해서 받은 URL로 이미지를 가져와야해요
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: url) {
                URLSession.shared.dataTask(with: url) { (data, res, err) in
                    if let _ = err {
                        DispatchQueue.main.async {
                            self.image = UIImage()
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        if let data = data, let image = UIImage(data: data) {
                            print("CACHE>> No cache I'll make new")
                            // 이때 서버통신을 통해서 이미지를 가져왔으면 memory와 disk cache에 저장해줘야 캐시처리가 되겠죠?!
                            self.image = image
                            // 다운로드된 이미지를 메모리 캐시에 저장
                            ImageCacheManager.shared.setObject(image, forKey: cacheKey as NSString)
                            // 다운로드된 이미지를 디스크 캐시에 저장
                            fileManager.createFile(atPath: filePath.path, contents: image.jpegData(compressionQuality: 0.4), attributes: nil)
                        }
                    }
                }.resume()
            }
        }
    }
}
