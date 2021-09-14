//
//  ViewController.swift
//  URLSession+Caching
//
//  Created by Wonseok Lee on 2021/09/13.
//

import UIKit
import Then
import SnapKit

class ViewController: UIViewController {
    // MARK: UI
    private lazy var timerLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20)
    }
    private lazy var imageView = UIImageView().then {
        $0.backgroundColor = .systemGray2
        $0.setRounded(radius: $0.frame.height/2)
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
    }
    private lazy var loadBtn = UIButton().then {
        $0.addTarget(self, action: #selector(tappedLoad), for: .touchUpInside)
        $0.setupButton(title: "Load", color: .white, font: UIFont.systemFont(ofSize: 25), backgroundColor: .black, state: .normal, radius: 20)
    }
    private lazy var activityIndicator = UIActivityIndicatorView()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
}

// MARK: Layout
extension ViewController {
    private func setLayout() {
        self.view.backgroundColor = .white
        setRepeatTimer(0.1, true)
        imageLayout()
        setTimerLabel()
        btnLayout()
    }
    
    private func setRepeatTimer(_ interval: TimeInterval, _ rp: Bool) {
        Timer.scheduledTimer(withTimeInterval: interval, repeats: rp) { [weak self] _ in
            self?.timerLabel.text = "\(Date().timeIntervalSince1970)"
        }
    }
    
    private func imageLayout() {
        view.add(imageView) {
            $0.snp.makeConstraints {
                $0.centerX.centerY.equalToSuperview()
                $0.width.height.equalTo(300)
            }
        }
        
        imageView.add(activityIndicator) {
            $0.snp.makeConstraints {
                $0.centerX.centerY.equalToSuperview()
            }
        }
    }
    private func setTimerLabel() {
        view.add(timerLabel) {
            $0.snp.makeConstraints { [self] in
                $0.centerX.equalToSuperview()
                $0.bottom.equalTo(imageView.snp.top)
            }
        }
    }
    
    private func btnLayout() {
        view.add(loadBtn) { [self] in
            $0.snp.makeConstraints {
                $0.top.equalTo(imageView.snp.bottom).offset(20)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(imageView.snp.width)
                $0.height.equalTo(50)
            }
        }
    }
    
    @objc
    private func tappedLoad() {
        setVisibleWithAnimation(activityIndicator, true)
        CAFETIService.shared.fetchCAFETIData(answers: [1,2,2,2]) { [self] response in
            switch response {
            case .success(let data):
                self.imageView.setImageUrl(data.result.img)
                DispatchQueue.main.sync {
                    setVisibleWithAnimation(activityIndicator, false)
                }
                return
            case .requestErr(let err):
                print(err)
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    private func setVisibleWithAnimation(_ v: UIView?, _ s: Bool) {
        guard let v = v else { return }
        UIView.animate(withDuration: 0.3, animations: { [weak v] in
            v?.isHidden = !s
        }, completion: { [weak self] _ in
            self?.view.layoutIfNeeded()
        })
    }
}

