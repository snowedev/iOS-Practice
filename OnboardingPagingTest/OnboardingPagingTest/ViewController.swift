//
//  ViewController.swift
//  OnboardingPagingTest
//
//  Created by Wonseok Lee on 2021/10/17.
//

import UIKit
import SnapKit
import Then
/**
 - Description
두개 컬렉션 뷰 스크롤이 동시에 이루어지는 예제
skip버튼 누르면 맨 마지막으로
 */
class ViewController: UIViewController {
    // MARK: Variables
    private let layout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    private let colorArr: [UIColor] = [.red, .orange, .blue, .green, .gray]
    
    // MARK: Components
    private lazy var testLabel = UILabel()
    private lazy var firstCV = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
        $0.delegate = self
        $0.dataSource = self
    }
    private lazy var secCV = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
        $0.delegate = self
        $0.dataSource = self
    }
    private lazy var skipBtn = UIButton().then {
        $0.setTitle("skip", for: .normal)
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.skipBtn.addTarget(self, action: #selector(moveToLast), for: .touchUpInside)
        setLayout()
        firstCV.register(CVcell.self, forCellWithReuseIdentifier: CVcell.identifier)
        secCV.register(CVcell.self, forCellWithReuseIdentifier: CVcell.identifier)
    }
    
    // MARK: Layout
    private func setLayout() {
        self.view.addSubview(firstCV)
        firstCV.snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
            $0.height.equalTo((self.view.frame.height/2))
        }
        self.view.addSubview(secCV)
        secCV.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.top.equalTo(self.firstCV.snp.bottom).offset(10)
        }
        self.view.addSubview(skipBtn)
        skipBtn.snp.makeConstraints {
            $0.right.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    @objc
    private func moveToLast() {
        firstCV.scrollToItem(at: IndexPath(item: 4, section: 0), at: .left, animated: true)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CVcell.identifier, for: indexPath) as! CVcell
        cell.backgroundColor = colorArr[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch scrollView {
        case firstCV:
            secCV.contentOffset.x = scrollView.contentOffset.x
        case secCV:
            firstCV.contentOffset.x = scrollView.contentOffset.x
        default:
            break
        }
    }
}

class CVcell: UICollectionViewCell {
    static var identifier = "CVcell"
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
