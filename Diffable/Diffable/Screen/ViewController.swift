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
    private lazy var tableView = UITableView(frame: view.bounds, style: .grouped).then {
        $0.register(TransactionCell.self, forCellReuseIdentifier: TransactionCell.className)
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.delegate = self
    }
    private var dataSource : DataSource!
    private var transactionData = [(Int, [Transaction])]()
    private var snapshot = NSDiffableDataSourceSnapshot<String, Transaction>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayout()
        loadData()
        configureDataSource()
        updateData(on: transactionData)
    }
}

// MARK: Layout

extension ViewController {
    private func setLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

// MARK: TableView Settings

extension ViewController: UITableViewDelegate {
    private func loadData() {
        // Bundle 내에 있는 json 파일 읽어오기
        if let data = readLocalFile(forName: "sample_data") {
            transactionData = parse(jsonData: data)
        }
    }
    
    private func configureDataSource() {
        dataSource = DataSource(tableView: self.tableView) { tableView, indexPath, item in
            return self.configure(TransactionCell.self, with: item, for: indexPath)
        }
        tableView.dataSource = dataSource
    }
    
    ///Configure any type of cell that conforms to selfConfiguringAnnotationCell!
    private func configure<T: TransactionCell>(_ cellType: T.Type, with item: Transaction, for indexPath: IndexPath) -> T {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellType.className, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        
        cell.dataBinding(model: item)
        cell.awakeFromNib()
        return cell
    }
    
    func updateData(on model: [(Int, [Transaction])]) {
        transactionData.forEach { (key, data) in
            snapshot.appendSections(["\(key)"])
            snapshot.appendItems(data)
        }
        
        DispatchQueue.main.async { [self] in
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        print(section)
        return UIView().then {
            $0.add(UILabel().then {
                $0.textColor = .black
                $0.text = "\(transactionData[section].0)"
            }) {
                $0.snp.makeConstraints {
                    $0.centerY.equalToSuperview()
                }
            }
            $0.backgroundColor = .systemGray5
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

class DataSource: UITableViewDiffableDataSource<String, Transaction> {
    //
}
