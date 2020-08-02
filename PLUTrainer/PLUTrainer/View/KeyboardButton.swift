//
//  KeyboardButton.swift
//  PLUTrainer
//
//  Created by Mondale on 6/4/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class KeyboardButton: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configure()
    }

    init(title: String) {
        super.init(frame: .zero)
        configure()
        setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray6
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont(name: "SFProText-Light", size: 24)
//        addTarget(self, action: #selector(returnTitle), for: .touchUpInside)
    }

//    @objc func returnTitle() -> String{
//        let quizVC = QuizVC()
//        
//        guard let titleLabel = titleLabel else{
//            return "No Title"
//        }
//        print(titleLabel.text ?? "No Value")
//        quizVC.userInput = titleLabel.text ?? "No Value"
//        print(quizVC.userInput)
//        return titleLabel.text ?? "No Value"
//        
//        
//    }
    
}


extension UIButton {
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.1
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        flash.autoreverses = true
        layer.add(flash, forKey: nil)
    }
}
