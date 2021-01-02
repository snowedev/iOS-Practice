//
//  KakaoTemplateVC.swift
//  FunctionTest
//
//  Created by 이원석 on 2020/12/30.
//

//import UIKit
//import KakaoSDKCommon
//import KakaoSDKLink
//import KakaoSDKTemplate
//
//class KakaoTemplateVC: UIViewController {
//    
//    @IBOutlet weak var kakaoTemplateView: UIView!{
//        didSet{
//            kakaoTemplateView.makeRounded(cornerRadius: 20.0)
//        }
//    }
//    @IBOutlet weak var messageTextField: UITextField!{
//        didSet{
//            messageTextField.makeRounded(cornerRadius: 20.0)
//        }
//    }
//    @IBOutlet weak var kakaoSendBtn: UIButton!{
//        didSet{
//            kakaoSendBtn.makeRounded(cornerRadius: 20.0)
//        }
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//    
//    @IBAction func kakaoSend(_ sender: Any) {
//        let template = TextTemplate.init(text: messageTextField.text ?? "안녕하세요", link: Link(), buttonTitle: "Cherish🎄")
//        // 카카오링크 실행
//        LinkApi.shared.defaultLink(templatable: template) {(linkResult, error) in
//            if let error = error {
//                print(error)
//            }
//            else {
//                print("defaultLink() success.")
//                if let linkResult = linkResult {
//                    UIApplication.shared.open(linkResult.url, options: [:], completionHandler: nil)
//                }
//            }
//        }
//    }
//}
