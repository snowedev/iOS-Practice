//
//  UIViewController+Extension.swift
//  CommonlyUsedStorage
//
//  Created by Wonseok Lee on 2021/06/14.
//

import UIKit

extension UIViewController
{
    // MARK: - 확인 취소 Alert 생성
    func makeRequestAlert(title : String,
                   message : String,
                   okAction : ((UIAlertAction) -> Void)?,
                   cancelAction : ((UIAlertAction) -> Void)? = nil,
                   completion : (() -> Void)? = nil)
    {
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        let alertViewController = UIAlertController(title: title, message: message,
                                                    preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: okAction)
        alertViewController.addAction(okAction)
        
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: cancelAction)
        alertViewController.addAction(cancelAction)
        

        self.present(alertViewController, animated: true, completion: completion)
    }
    
    // MARK: - 확인 Alert 생성
    func makeAlert(title : String,
                   message : String,
                   okAction : ((UIAlertAction) -> Void)? = nil,
                   completion : (() -> Void)? = nil)
    {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        let alertViewController = UIAlertController(title: title, message: message,
                                                    preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: okAction)
        alertViewController.addAction(okAction)
        
        
        self.present(alertViewController, animated: true, completion: completion)
    }
    
    // MARK: - 토스트
    func showToast(message : String, font: UIFont, bgColor: UIColor, textColor: UIColor, width: Int, bottomY: Int, completion: @escaping () -> Void) {
        let guide = view.safeAreaInsets.bottom
        let y = self.view.frame.size.height-guide
        
        let toastLabel = UILabel(
            frame: CGRect( x: self.view.frame.size.width/2 - CGFloat(width)/2,
                           y: y-CGFloat(bottomY),
                           width: CGFloat(width),
                           height: 33
            )
        )
        
        toastLabel.backgroundColor = bgColor
        toastLabel.textColor = textColor
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 15
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
            completion()
        })
    }
}
