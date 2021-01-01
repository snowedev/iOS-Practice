//
//  WaterFlowPopUpVC.swift
//  FunctionTest
//
//  Created by 이원석 on 2020/12/30.
//

import UIKit
import MessageUI
import CallKit

class WaterFlowPopUpVC: UIViewController,CXCallObserverDelegate {
    var ct : FetchedContact?
    let callObserver = CXCallObserver()
    var didDetectOutgoingCall = false
    
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
    }
    
    //MARK: -@IBAction
    @IBAction func backToFlow(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// Call Material
    func showCallAlert() {
        guard let url = NSURL(string: "tel://" + "\(ct?.telephone ?? "0")"),
            UIApplication.shared.canOpenURL(url as URL) else {
                return
        }

        callObserver.setDelegate(self, queue: nil)

        didDetectOutgoingCall = false

        //we only want to add the observer after the alert is displayed,
        //that's why we're using asyncAfter(deadline:)
        UIApplication.shared.open(url as URL, options: [:]) { [weak self] success in
            if success {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self?.addNotifObserver()
                }
            }
        }
    }
    /// Contact way1: Call
    @IBAction func calling(_ sender: Any) {
        showCallAlert()
    }
//        callObserver.setDelegate(self, queue: nil)
//        didDetectOutgoingCall = false
//
//        //we only want to add the observer after the alert is displayed,
//        //that's why we're using asyncAfter(deadline:)
//        if let url = NSURL(string: "tel://" + "\(ct?.telephone ?? "0")"),
//           UIApplication.shared.canOpenURL(url as URL) {
//            /// 연락 수단 선택 창 dismiss
//            self.dismiss(animated: true){
//                UIApplication.shared.open(url as URL, options: [:]){ [weak self] success in
//                    if success {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                            self?.addNotifObserver()
//                        }
//                    }
//                }
//            }
//        }
    
    
    func addNotifObserver() {
        let selector = #selector(appDidBecomeActive)
        let notifName = UIApplication.didBecomeActiveNotification
        NotificationCenter.default.addObserver(self, selector: selector, name: notifName, object: nil)
    }
    
    @objc func appDidBecomeActive() {
        //if callObserver(_:callChanged:) doesn't get called after a certain time,
        //the call dialog was not shown - so the Cancel button was pressed
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            if !(self?.didDetectOutgoingCall ?? true) {
                print("Cancel button pressed")
            }
        }
    }
    
    func callObserver(_ callObserver: CXCallObserver, callChanged call: CXCall) {
        if call.isOutgoing && !didDetectOutgoingCall {
            didDetectOutgoingCall = true
            let storyBoard: UIStoryboard = UIStoryboard(name: "Review", bundle: nil)
            if let vc = storyBoard.instantiateViewController(withIdentifier: "ReviewVC") as? ReviewVC{
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
            print("Call button pressed")
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
        guard let pvc = self.presentingViewController else {return}
        
        if UIApplication.shared.canOpenURL(kakaoTalkURL! as URL) {
            /// 연락 수단 선택 창 dismiss
            self.dismiss(animated: true){
                UIApplication.shared.open(kakaoTalkURL! as URL){_ in
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Review", bundle: nil)
                    if let vc = storyBoard.instantiateViewController(withIdentifier: "ReviewVC") as? ReviewVC{
                        vc.modalPresentationStyle = .fullScreen
                        pvc.present(vc, animated: true, completion: nil)
                    }
                }
            }
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

