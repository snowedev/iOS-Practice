//
//  ViewController.swift
//  Diffable
//
//  Created by Wonseok Lee on 2022/01/15.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController {
    private lazy var tableView = UITableView().then {
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.delegate = self
    }
    var dataSource: UITableViewDiffableDataSource<String, Transaction>!
    var transactionData = [Transaction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayout()
        // Bundle 내에 있는 json 파일 읽어오기
        if let data = readLocalFile(forName: "sample_data") {
            transactionData = parse(jsonData: data)
            print(transactionData)
        }
        setupDataSource()
        performQuery()
    }
    
    private func setupDataSource() {
        self.tableView.register(TransactionCell.self, forCellReuseIdentifier: TransactionCell.className)
        
        self.dataSource = UITableViewDiffableDataSource<String, Transaction>(tableView: self.tableView) { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionCell.className, for: indexPath) as? TransactionCell else {
                preconditionFailure()
            }
            
            print(itemIdentifier)
            cell.dataBinding(model: itemIdentifier)
            cell.awakeFromNib()
            return cell
        }
        tableView.dataSource = self.dataSource
    }

    func performQuery() {
        var snapshot = NSDiffableDataSourceSnapshot<String, Transaction>()
        snapshot.appendSections(["main"])
        snapshot.appendItems(transactionData)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
}

extension ViewController {
    private func setLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}


extension ViewController: UITableViewDelegate {
    
}
