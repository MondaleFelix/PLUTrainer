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
    
        self.backgroundColor = .red
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
        addTarget(self, action: #selector(returnButtonValue), for: .touchUpInside)
    }
    
    @objc func returnButtonValue(_ sender: UIButton) -> String {
        print(sender.currentTitle!)
        return sender.currentTitle!
    }
}
