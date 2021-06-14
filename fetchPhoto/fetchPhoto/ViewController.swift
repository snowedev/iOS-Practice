//
//  ViewController.swift
//  fetchPhoto
//
//  Created by Wonseok Lee on 2021/06/15.
//

import UIKit
import Photos

// info.plist에 Privacy - Photo Library Usage Description추가
class ViewController: UIViewController {
    @IBOutlet weak var sampleImage: UIImageView!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    }
    
    @IBAction func addPhotoTapped(_ sender: Any) {
        let alert =  UIAlertController(title: "인터뷰 사진 추가", message: nil, preferredStyle: .actionSheet)
        let library =  UIAlertAction(title: "앨범에서 사진 선택", style: .default) { (action) in self.openPhotoLibrary()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController {
    // MARK: - Open Photo Library
    func openPhotoLibrary() {
        /// 사진 접근 권한이 허용되었는지 검사
        switch PHPhotoLibrary.authorizationStatus() {
        /// 권한이 거부된 경우
        case .denied:
            print("denied")
            /// 설정창에서 권한을 재설정 하게끔 유도한다
            if let appName = Bundle.main.infoDictionary!["CFBundleName"] as? String {
                let alert = UIAlertController(title: "설정", message: "\(appName)의 사진 접근 권한이\n허용되어 있지 않습니다.\n설정에서 변경 가능합니다.", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "취소", style: .default) { (action) in
                    
                }
                let confirmAction = UIAlertAction(title: "설정", style: .default) { (action) in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }
                
                alert.addAction(cancelAction)
                alert.addAction(confirmAction)
                self.present(alert, animated: true, completion: nil)
            }
        /// restricted
        case .restricted:
            print("restricted")
            break
        /// 권한이 허용된 경우
        case .authorized:
            print("authorized")
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            
            picker.modalPresentationStyle = .fullScreen
            self.present(self.picker, animated: true, completion: nil)
        /// 권한 허용을 묻기 전인 경우 (최초 1회)
        case .notDetermined:
            print("notDetermined")
            PHPhotoLibrary.requestAuthorization({ state in
                if state == .authorized {
                    DispatchQueue.main.async {
                        self.picker.sourceType = .photoLibrary
                        self.picker.allowsEditing = true
                        
                        self.picker.modalPresentationStyle = .fullScreen
                        self.present(self.picker, animated: true, completion: nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        if let appName = Bundle.main.infoDictionary!["CFBundleName"] as? String {
                            let alert = UIAlertController(title: "설정", message: "\(appName)의 사진 접근 권한이\n허용되어 있지 않습니다.\n설정에서 변경 가능합니다.", preferredStyle: .alert)
                            let cancelAction = UIAlertAction(title: "취소", style: .default) { (action) in
                                
                            }
                            let confirmAction = UIAlertAction(title: "설정", style: .default) { (action) in
                                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                            }
                            
                            alert.addAction(cancelAction)
                            alert.addAction(confirmAction)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                    self.dismiss(animated: true, completion: nil)
                }
            })
        default:
            print("break")
            break
        }
    }
}

// MARK: - Protocols
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 선택된 이미지를 각 카테고리에 맞게 구조체에 아카이빙
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            sampleImage.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
}
