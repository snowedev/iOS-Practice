//
//  WaterFlowChoiceVC.swift
//  FunctionTest
//
//  Created by 이원석 on 2020/12/31.
//

import UIKit

class WaterFlowChoiceVC: UIViewController {
    var b_ct: FetchedContact?
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
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
    @IBAction func goLater(_ sender: Any) {
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
