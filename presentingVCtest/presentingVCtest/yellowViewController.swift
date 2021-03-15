//
//  yellowViewController.swift
//  presentingVCtest
//
//  Created by 이원석 on 2020/10/18.
//

import UIKit

class yellowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ylbtn(_ sender: Any) {
        guard let yellow = self.storyboard?.instantiateViewController(identifier: "orangeViewController") else {
            return
        }
        
        present(yellow, animated: true, completion: nil)
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
