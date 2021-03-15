//
//  orangeViewController.swift
//  presentingVCtest
//
//  Created by 이원석 on 2020/10/18.
//

import UIKit

class orangeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func oragnebtn(_ sender: Any) {
        guard let org = self.storyboard?.instantiateViewController(withIdentifier: "greenViewController") else {
            return
        }
        
        self.navigationController?.pushViewController(org, animated: true)
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
