//
//  WaterFlowChoiceVC.swift
//  FunctionTest
//
//  Created by 이원석 on 2020/12/31.
//

import UIKit

class WaterFlowChoiceVC: UIViewController {
    var b_ct: FetchedContact?
    
    //MARK: -@IBOutlet
    @IBOutlet weak var choiceView: UIView!{
        didSet{
            choiceView.makeRounded(cornerRadius: 20.0)
        }
    }
    @IBOutlet weak var waterBtn: UIButton!{
        didSet{
            waterBtn.makeRounded(cornerRadius: 20.0)
        }
    }
    @IBOutlet weak var laterBtn: UIButton!{
        didSet{
            laterBtn.makeRounded(cornerRadius: 20.0)
        }
    }
    
    //MARK: -viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: -@IBAction
    /// 뒤로가기 Action
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    ///물주기 Action
    @IBAction func goWater(_ sender: Any) {
        guard let pvc = self.presentingViewController else {return}
        
        self.dismiss(animated: true) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "WaterFlow", bundle: nil)
            if let vc = storyBoard.instantiateViewController(withIdentifier: "WaterFlowPopUpVC") as? WaterFlowPopUpVC{
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = .crossDissolve
                vc.ct = self.b_ct
                pvc.self.present(vc, animated: true, completion: nil)
            }
        }
        
    }
    ///미루기 Action
    @IBAction func goLater(_ sender: Any) {
    }
}
