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
    
    //MARK: -@IBOutlet
    @IBOutlet weak var popupView: UIView!{
        didSet{
            popupView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var firstTagLabel: UILabel!{
        didSet{
            firstTagLabel.layer.cornerRadius = 10
            firstTagLabel.layer.borderWidth = 1
            firstTagLabel.layer.borderColor = UIColor.blue.cgColor
        }
    }
    @IBOutlet weak var callingBtn: UIButton!
    @IBOutlet weak var smsBtn: UIButton!
    @IBOutlet weak var kakaoBtn: UIButton!
    
    //MARK: -ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationCenter()
    }
    
    //MARK: -Ect Func
    func notificationCenter(){
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    @objc func appMovedToBackground() {
        print("App moved to background!")
    }
    
    //MARK: -@IBAction
    @IBAction func backToFlow(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /// Contact way1: Call
    @IBAction func calling(_ sender: Any) {
        
        if let url = NSURL(string: "tel://" + "\(ct?.telephone ?? "0")"),
           UIApplication.shared.canOpenURL(url as URL) {
            /// 연락 수단 선택 창 dismiss
            self.dismiss(animated: true, completion: nil)
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    /// Contact way2: Message
    @IBAction func smsing(_ sender: Any) {
        //        guard let pvc = self.presentingViewController else {return}
        //        self.dismiss(animated: true) {
        //            let storyBoard: UIStoryboard = UIStoryboard(name: "SMS", bundle: nil)
        //            if let vc = storyBoard.instantiateViewController(withIdentifier: "SMSVC") as? SMSVC{
        //                vc.modalPresentationStyle = .overCurrentContext
        //                vc.modalTransitionStyle = .crossDissolve
        //                vc.sms_ct = self.ct
        //                pvc.present(vc, animated: true, completion: nil)
        //            }
        //        }
        let messageComposer = MFMessageComposeViewController()
        messageComposer.messageComposeDelegate = self
        if MFMessageComposeViewController.canSendText(){
            messageComposer.recipients = ["\(ct?.telephone ?? "0")"]
            messageComposer.body = ""
            messageComposer.modalPresentationStyle = .currentContext
            //messageComposer.modalTransitionStyle = .crossDissolve
            self.present(messageComposer, animated: true)
        }
    }
    
    /// Contact way3: Kakao Talk
    @IBAction func kakaotalking(_ sender: Any) {
        let kakaoTalk = "kakaotalk://"
        let kakaoTalkURL = NSURL(string: kakaoTalk)
        
        if UIApplication.shared.canOpenURL(kakaoTalkURL! as URL) {
            UIApplication.shared.openURL(kakaoTalkURL! as URL)
            /// 연락 수단 선택 창 dismiss
            self.dismiss(animated: true, completion: nil)
        }
        else {
            print("No kakaostory installed.")
        }
    }
}


//MARK: -Protocol Extension
extension WaterFlowPopUpVC: MFMessageComposeViewControllerDelegate{
    /// 메시지 전송 결과
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

