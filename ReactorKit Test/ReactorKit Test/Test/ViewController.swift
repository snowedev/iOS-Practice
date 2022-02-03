//
//  ViewController.swift
//  ReactorKit Test
//
//  Created by 60156673 on 2022/02/03.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa
// https://medium.com/styleshare/reactorkit-시작하기-c7b52fbb131a

/**
 - Description
 View는 Action을 Reactor에게 전달한다.
 Reactor는 전달받은 Action에 따라 비즈니스 로직을 수행한다.
 그 후, Reactor는 상태를 변경하여 View에게 전달한다.
 
 따라서, View는 액션을 던진 이후 Reactor가 주는 State만 바라보고 있다.

 ---
 
 View 프로토콜을 적용하면 뷰를 정의할 수 있다.
 - DisposeBag 속성과 bind(reactor:) 메서드를 필수로 정의해야한다.
 */
class ViewController: UIViewController, View {

    typealias Reactor = CounterViewReactor
    
    private lazy var increaseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var decreaseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loadingIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.center = self.view.center
        indicator.style = UIActivityIndicatorView.Style.medium
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(increaseButton)
        stack.addArrangedSubview(valueLabel)
        stack.addArrangedSubview(decreaseButton)
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    private func setLayout() {
        self.view.backgroundColor = .lightGray
        self.view.addSubview(contentStackView)
        self.view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            loadingIndicator.bottomAnchor.constraint(equalTo: contentStackView.topAnchor),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 50),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func bind(reactor: Reactor) {
        // Action 바인딩
        // increaseButton이 탭되면 increase 액션으로 변환하여 reactor의 action에 바인딩해주겠다
        increaseButton.rx.tap
            .map { Reactor.Action.increase }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        decreaseButton.rx.tap
            .map { Reactor.Action.decrease }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // reactor가 새로운 state를 주면, state안에 있는 value로 valueLabel을 업데이트 시켜준다.
        // 다만 value가 이전 값이랑 다를 경우에만(distinctUntilChanged)
        reactor.state.map { $0.value }
            .distinctUntilChanged()
            .map { "\($0)" }
            .bind(to: valueLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: loadingIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }
}

