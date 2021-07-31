//
//  loginVC.swift
//  test
//
//  Created by Wonseok Lee on 2021/08/01.
//

import UIKit

class loginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        if let dvc = self.storyboard?.instantiateViewController(withIdentifier: "naviVC") as? naviVC {
            self.navigationController?.pushViewController(dvc, animated: true)
        }
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
