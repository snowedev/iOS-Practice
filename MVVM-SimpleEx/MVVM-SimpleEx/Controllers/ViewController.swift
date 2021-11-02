//
//  ViewController.swift
//  MVVM-SimpleEx
//
//  Created by Wonseok Lee on 2021/11/02.
//

import UIKit
import SnapKit
import Then

final class ViewController: UIViewController {
    private let viewModel = PersonViewModel()
    
    // MARK: UI Component
    
    private lazy var nameTextField = UITextField().then {
        $0.backgroundColor = .secondarySystemFill
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .label
        $0.placeholder = "이름을 입력해주세요"
    }
    private lazy var ageTextField = UITextField().then {
        $0.backgroundColor = .secondarySystemFill
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .label
        $0.placeholder = "나이를 입력해주세요"
    }
    private lazy var nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20)
        $0.textColor = .label
    }
    private lazy var birthYearLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20)
        $0.textColor = .label
    }
    private lazy var submitBtn = UIButton().then {
        $0.backgroundColor = .orange
        $0.setTitle("Submit", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        print("<<<< ViewDidLoad >>>>")
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setLayout()
        viewModel.userName.bind { [weak self] userName in
            self?.nameLabel.text = userName + "님은"
        }
        
        viewModel.birthYear.bind { [weak self] birthYear in
            self?.birthYearLabel.text = "\(birthYear)년도에 태어나셨습니다."
        }
    }
}

extension ViewController {
    private func setLayout() {
        self.view.addSubview(nameTextField)
        self.view.addSubview(ageTextField)
        self.view.addSubview(nameLabel)
        self.view.addSubview(birthYearLabel)
        self.view.addSubview(submitBtn)
        
        nameTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(40)
            $0.width.equalTo(UIScreen.main.bounds.width-50)
            $0.height.equalTo(40)
        }
        
        ageTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.nameTextField.snp.bottom).offset(20)
            $0.width.height.equalTo(self.nameTextField)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.ageTextField.snp.bottom).offset(20)
        }
        
        birthYearLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.nameLabel.snp.bottom)
        }
        
        submitBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            $0.width.equalTo(self.nameTextField)
            $0.height.equalTo(60)
        }
    }
    
    @objc func submitAction() {
        guard let name = nameTextField.text, !name.isEmpty else { return }
        guard let age = ageTextField.text, !age.isEmpty else { return }
        
        viewModel.calculateBirthYear(name: name, age: age)
    }
}

