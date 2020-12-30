//
//  WaterFlowPopUpVC.swift
//  FunctionTest
//
//  Created by 이원석 on 2020/12/30.
//

import UIKit
import MessageUI

class WaterFlowPopUpVC: UIViewController {
    var ct : FetchedContact?
    
    @IBOutlet weak var popupView: UIView!{
        didSet{
            popupView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var callingBtn: UIButton!
    @IBOutlet weak var smsBtn: UIButton!
    @IBOutlet weak var kakaoBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backToFlow(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func calling(_ sender: Any) {
        
        if let url = NSURL(string: "tel://" + "\(ct?.telephone ?? "0")"),
           UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    @IBAction func smsing(_ sender: Any) {
        let messageComposer = MFMessageComposeViewController()
        messageComposer.messageComposeDelegate = self
        if MFMessageComposeViewController.canSendText(){
            messageComposer.recipients = ["\(ct?.telephone ?? "0")"]
            messageComposer.body = "디폴트 메시지도 설정할 수 있습니다."
            messageComposer.modalPresentationStyle = .currentContext
//            messageComposer.modalTransitionStyle = .crossDissolve
            self.present(messageComposer, animated: true, completion: nil)
        }
    }
    
    @IBAction func kakaotalking(_ sender: Any) {
        print("no Yet")
    }
    
}


extension WaterFlowPopUpVC: MFMessageComposeViewControllerDelegate{
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case MessageComposeResult.sent:
            print("전송 완료")
            break
        case MessageComposeResult.cancelled:
            print("취소")
            break
        case MessageComposeResult.failed:
            print("전송 실패")
            break
        @unknown default:
            fatalError()
        }
        controller.dismiss(animated: true, completion: nil)
    }
}

