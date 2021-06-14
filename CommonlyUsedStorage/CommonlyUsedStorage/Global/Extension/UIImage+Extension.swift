//
//  UIImage+Extension.swift
//  CommonlyUsedStorage
//
//  Created by Wonseok Lee on 2021/06/14.
//

import UIKit
import Kingfisher


extension UIImageView {
    //MARK: - 사진 가져오기
    func setImage(with urlString: String) {
        let cache = ImageCache.default
        cache.retrieveImage(forKey: urlString, options: nil) { [self] _ in // 캐시에서 키를 통해 이미지를 가져온다.
            if let image = image { // 만약 캐시에 이미지가 존재한다면
                self.image = image // 바로 이미지를 셋한다.
            } else {
                if urlString != ""
                {
                    let url = URL(string: urlString) // 캐시가 없다면
                    let resource = ImageResource(downloadURL: url!, cacheKey: urlString) // URL로부터 이미지를 다운받고 String 타입의 URL을 캐시키로 지정하고
                    self.kf.setImage(with: resource,options: [.transition(.fade(0.5))])
                }
            }
        }
    }

    //MARK: - 동그랗게 사진 가져오기
    func setCircleImage(with urlString: String){
        let cache = ImageCache.default
        cache.retrieveImage(forKey: urlString, options: nil) { [self] _ in // 캐시에서 키를 통해 이미지를 가져온다.
            
            
            self.layer.borderWidth = 1.0
            self.layer.masksToBounds = false
            self.layer.borderColor = .init(srgbRed: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            self.layer.cornerRadius = self.frame.size.height/2
            self.clipsToBounds = true
            
            if urlString == ""
            {
                self.image = UIImage(named: "classIcProfile")
            }
            else
            {
                if let image = image { // 만약 캐시에 이미지가 존재한다면
                    self.image = image // 바로 이미지를 셋한다.
                } else {
                    let url = URL(string: urlString) // 캐시가 없다면
                    let resource = ImageResource(downloadURL: url!, cacheKey: urlString) // URL로부터 이미지를 다운받고 String 타입의 URL을 캐시키로 지정하고
                    self.kf.setImage(with: resource) // 이미지를 셋한다.
                }
            }
        }
    } // 프로필 사진은 원으로 깎아야 한다
}
