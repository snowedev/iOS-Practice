//
//  ViewController.swift
//  prepareForReuseTest
//
//  Created by Wonseok Lee on 2021/07/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Test.shared.switchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TestTableViewCell.identifier, for: indexPath) as? TestTableViewCell else { return UITableViewCell() }
        cell.testLabel.text = "\(indexPath.row)"
        cell.testSwitch.isOn = Test.shared.switchData[indexPath.row]
        cell.idx = indexPath.row
        return cell
    }
}

