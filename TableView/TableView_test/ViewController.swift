//
//  ViewController.swift
//  TableView_test
//
//  Created by 이원석 on 2020/10/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    // cell 내부에 들어갈 내용들의 array
    let contentArray = [
            "simply dummy text of the printing and",
            
            "um has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type ",
            
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribestablished fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, co",
            
            "ho loves pain itself, who seeks after it and wants to have it, simply because it is pai",
            
            "established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, co",
            
            "ho loves pain itself, who seeks after it and wants to have it, simply because it is pai",
            
            "a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is thaai",
            
            "ho loves pain ita reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is to have it, simply because it is pai",
            
            "ho loves pain itself, who seeks after it and wants to have it, simplho loves pain ita reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is to have it, simply because it y because it is pai",
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 셀 리소스 파일 가져오기
        let myTableViewCellNib = UINib(nibName: "MyTableViewCell", bundle: nil)
        
        // 셀에 리소스 등록
        self.myTableView.register(myTableViewCellNib, forCellReuseIdentifier: "myTableViewCell")
        
        self.myTableView.rowHeight = UITableView.automaticDimension
        self.myTableView.estimatedRowHeight = 120
                
        // 아주 중요
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
                
        print("contentArray.count : \(contentArray.count)")
    }

}

extension ViewController : UITableViewDelegate {

}

extension ViewController : UITableViewDataSource {
    
    // 테이블의 cell의 갯수을 의미
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contentArray.count
    }
    
    // 각 cell에 대한 설정
    // cellForRowAt? -> 뷰와 데이터를 연결 시켜줌
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myTableView.dequeueReusableCell(withIdentifier: "myTableViewCell", for: indexPath) as? MyTableViewCell else {
            fatalError("이런 셀은 존재하지 않음")
        }
        
        cell.userContentLabel.text = contentArray[indexPath.row]
        
        return cell
    }
    
}
