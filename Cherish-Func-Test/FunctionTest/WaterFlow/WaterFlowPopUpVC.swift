//
//  WaterFlowPopUpVC.swift
//  FunctionTest
//
//  Created by 이원석 on 2020/12/30.
//

import UIKit

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
        guard let pvc = self.presentingViewController else {return}
        self.dismiss(animated: true) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "SMS", bundle: nil)
            if let vc = storyBoard.instantiateViewController(withIdentifier: "SMSVC") as? SMSVC{
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = .crossDissolve
                vc.sms_ct = self.ct
                pvc.present(vc, animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func kakaotalking(_ sender: Any) {
        
        guard let pvc = self.presentingViewController else {return}
        
        self.dismiss(animated: true) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "KakaoTemplate", bundle: nil)
            if let vc = storyBoard.instantiateViewController(withIdentifier: "KakaoTemplateVC") as? KakaoTemplateVC{
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = .crossDissolve
                pvc.present(vc, animated: true, completion: nil)
            }
        }
    }
}

