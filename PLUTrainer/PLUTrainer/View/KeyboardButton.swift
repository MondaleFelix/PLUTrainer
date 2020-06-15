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
        
        if title == "del" || title == "ent"{
            self.backgroundColor = .blue
        } else {
            self.backgroundColor = .red
        }
        setTitle(title, for: .normal)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius = 20
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
//        addTarget(self, action: #selector(returnButtonValue), for: .touchUpInside)
    }

    
//    @objc func returnButtonValue(_ sender: UIButton ) -> String {
//        print(sender.currentTitle!)
//        sender.flash()
//        return sender.currentTitle!
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
//        flash.repeatCount = 3
        layer.add(flash, forKey: nil)
    }
}
