//
//  ViewController.swift
//  testProject
//
//  Created by Wonseok Lee on 2021/06/04.
//
// https://nsios.tistory.com/58
// https://velog.io/@cooo002/ios이미지-캐싱처리-개념

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func testTapped(_ sender: Any) {
        let url = URL.init(string: "https://upload.wikimedia.org/wikipedia/commons/0/09/Naver_Line_Webtoon_logo.png")
        let urlData = try! Data(contentsOf: url!)
        // 여기서 캐싱처리 하면 더 좋을 듯
        testImageView.image = UIImage(data: urlData)
    }
}

