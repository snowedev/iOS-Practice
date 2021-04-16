//
//  ViewController.swift
//  HapticFeedback
//
//  Created by 이원석 on 2021/04/16.
//

/*
 참고
 https://zeddios.tistory.com/726
 https://zeddios.tistory.com/725
*/

import UIKit

class ViewController: UIViewController {
    //MARK: -Generator 인스턴스화
    var feedbackGenerator: UINotificationFeedbackGenerator?
    var impactFeedbackGenerator: UIImpactFeedbackGenerator?
    var selectionFeedbackGenerator: UISelectionFeedbackGenerator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupGenerator()
    }
    
    private func setupGenerator(){
        self.feedbackGenerator = UINotificationFeedbackGenerator()
        self.selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        
        self.feedbackGenerator?.prepare()
        self.impactFeedbackGenerator?.prepare()
        self.selectionFeedbackGenerator?.prepare()
    }

    //MARK: -UINotificationFeedbackGenerator
    @IBAction func success(_ sender: Any) {
        self.feedbackGenerator?.notificationOccurred(.success)
    }
    @IBAction func warning(_ sender: Any) {
        self.feedbackGenerator?.notificationOccurred(.warning)
    }
    @IBAction func error(_ sender: Any) {
        self.feedbackGenerator?.notificationOccurred(.error)
    }
    
    //MARK: -UIImpactFeedbackGenerator
    @IBAction func heavy(_ sender: Any) {
        self.impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        self.impactFeedbackGenerator?.impactOccurred()
    }
    @IBAction func medium(_ sender: Any) {
        self.impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        self.impactFeedbackGenerator?.impactOccurred()
    }
    @IBAction func light(_ sender: Any) {
        self.impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        self.impactFeedbackGenerator?.impactOccurred()
    }
    
    //MARK: -UISelectionFeedbackGenerator
    @IBAction func selection(_ sender: Any) {
        self.selectionFeedbackGenerator?.selectionChanged()
    }
}

