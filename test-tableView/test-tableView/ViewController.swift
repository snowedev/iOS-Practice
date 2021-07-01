//
//  ViewController.swift
//  test-tableView
//
//  Created by Wonseok Lee on 2021/06/30.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
    
    @IBAction func tappedEdit(_ sender: Any) {
        guard let dvc = self.storyboard?.instantiateViewController(identifier: "inputVC") else { return }
        dvc.modalPresentationStyle = .fullScreen
        self.present(dvc, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MainData.sharedInstance.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView?.dequeueReusableCell(withIdentifier: testTVCell.identifier, for: indexPath) as? testTVCell else { return UITableViewCell() }
        cell.testLabel?.text = MainData.sharedInstance[indexPath.row].content
        return cell
    }
}



