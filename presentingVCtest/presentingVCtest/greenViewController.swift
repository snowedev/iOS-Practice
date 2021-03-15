//
//  greenViewController.swift
//  presentingVCtest
//
//  Created by 이원석 on 2020/10/18.
//

import UIKit

class greenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func grbtn(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        // 노란색 화면으로 돌아감
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
