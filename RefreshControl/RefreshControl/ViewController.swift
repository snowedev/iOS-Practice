//
//  ViewController.swift
//  RefreshControl
//
//  Created by Wonseok Lee on 2021/06/15.
//

import UIKit

class ViewController: UIViewController {
    var sampleList = ["A", "B", "C", "D", "E"]
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var sampleTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sampleTV.delegate = self
        sampleTV.dataSource = self
        initRefresh()
    }
    
    func initRefresh() {
        refreshControl.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        sampleTV.refreshControl = refreshControl
    }
    
    @objc func refreshTable(refresh: UIRefreshControl) {
        print("새로고침 시작!")
        sampleList.append("NEW!")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.sampleTV.reloadSections(IndexSet(integer: 0), with: .fade)
            refresh.endRefreshing()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sampleCell = tableView.dequeueReusableCell(withIdentifier: RefreshTVCell.identifier) as? RefreshTVCell else { return UITableViewCell() }
        sampleCell.setData(data: sampleList[indexPath.row])
        
        return sampleCell
    }
}
