//
//  SMSVC.swift
//  FunctionTest
//
//  Created by 이원석 on 2020/12/30.
//

import UIKit
import MessageUI

class SMSVC: UIViewController {
    var sms_ct: FetchedContact?
    @IBOutlet weak var smsView: UIView!{
        didSet{
            smsView.makeRounded(cornerRadius: 20.0)
        }
    }
    @IBOutlet weak var smsSendBtn: UIButton!{
        didSet{
            smsSendBtn.makeRounded(cornerRadius: 20.0)
        }
    }
    @IBOutlet weak var messageTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func smsSending(_ sender: Any) {
        let messageComposer = MFMessageComposeViewController()
        messageComposer.messageComposeDelegate = self
        if MFMessageComposeViewController.canSendText(){
            messageComposer.recipients = ["\(sms_ct?.telephone ?? "0")"]
            messageComposer.body = messageTextField.text
            messageComposer.modalPresentationStyle = .currentContext
            //            messageComposer.modalTransitionStyle = .crossDissolve
            self.present(messageComposer, animated: true, completion: nil)
        }
    }
}

extension SMSVC: MFMessageComposeViewControllerDelegate{
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
