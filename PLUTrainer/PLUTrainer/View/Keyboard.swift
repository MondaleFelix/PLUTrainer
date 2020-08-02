//
//  Keyboard.swift
//  PLUTrainer
//
//  Created by Mondale on 6/4/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

protocol ReturnButtonNameDelegate {
    func getButtonLabel(buttonName: String)
}

class Keyboard: UIView {
    
    // Vertically Stack View of all Keyboard Buttons
    let stackView = UIStackView()
    
    // Rows of buttons, horizontially
    var firstRow = UIStackView()
    var secondRow = UIStackView()
    var thirdRow = UIStackView()
    var fourthRow = UIStackView()
        
    var delegate: ReturnButtonNameDelegate!

    
    override init(frame: CGRect) {
        super.init(frame:frame)
        translatesAutoresizingMaskIntoConstraints = false
        configureFirstRow()
        configureSecondRow()
        configureThirdRow()
        configureFourthRow()
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStackView(){
        addSubview(stackView)
        clipsToBounds = true
        stackView.addArrangedSubview(firstRow)
        stackView.addArrangedSubview(secondRow)
        stackView.addArrangedSubview(thirdRow)
        stackView.addArrangedSubview(fourthRow)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        
        ])
        
    }
    // Buttons 1 - 3
    private func configureFirstRow(){
        
        let oneButton = KeyboardButton(title: "1")
        let twoButton = KeyboardButton(title: "2")
        let threeButton = KeyboardButton(title: "3")
        
        oneButton.addTarget(self, action: #selector(returnButtonValue), for: .touchUpInside)
        twoButton.addTarget(self, action: #selector(returnButtonValue), for: .touchUpInside)
        threeButton.addTarget(self, action: #selector(returnButtonValue), for: .touchUpInside)
        
        firstRow.addArrangedSubview(oneButton)
        firstRow.addArrangedSubview(twoButton)
        firstRow.addArrangedSubview(threeButton)
        firstRow.backgroundColor = .red
        firstRow.translatesAutoresizingMaskIntoConstraints = false
        firstRow.axis = .horizontal
        firstRow.distribution = .fillEqually
        
    }
    
    // Buttons 4 - 6
    private func configureSecondRow(){
        
        let fourButton = KeyboardButton(title: "4")
        let fiveButton = KeyboardButton(title: "5")
        let sixButton = KeyboardButton(title: "6")
        
        fourButton.addTarget(self, action: #selector(returnButtonValue), for: .touchUpInside)
        fiveButton.addTarget(self, action: #selector(returnButtonValue), for: .touchUpInside)
        sixButton.addTarget(self, action: #selector(returnButtonValue), for: .touchUpInside)
        
        
        secondRow.addArrangedSubview(fourButton)
        secondRow.addArrangedSubview(fiveButton)
        secondRow.addArrangedSubview(sixButton)
        
        secondRow.translatesAutoresizingMaskIntoConstraints = false
        secondRow.axis = .horizontal
        secondRow.distribution = .fillEqually
        
    }
    
    
    // Buttons 7 ,8, 9
    private func configureThirdRow(){
        
        let sevenButton = KeyboardButton(title: "7")
        let eightButton = KeyboardButton(title: "8")
        let nineButton = KeyboardButton(title: "9")
        
        sevenButton.addTarget(self, action: #selector(returnButtonValue), for: .touchUpInside)
        eightButton.addTarget(self, action: #selector(returnButtonValue), for: .touchUpInside)
        nineButton.addTarget(self, action: #selector(returnButtonValue), for: .touchUpInside)
        
        thirdRow.addArrangedSubview(sevenButton)
        thirdRow.addArrangedSubview(eightButton)
        thirdRow.addArrangedSubview(nineButton)
        
        thirdRow.translatesAutoresizingMaskIntoConstraints = false
        thirdRow.axis = .horizontal
        thirdRow.distribution = .fillEqually
        
    }
    
    
    // Buttons del, 0 , ent
    private func configureFourthRow(){
        
        let deleteButton = KeyboardButton(title: "del")
        let zeroButton = KeyboardButton(title: "0")
        let enterButton = KeyboardButton(title: "ent")
        deleteButton.addTarget(self, action: #selector(returnButtonValue), for: .touchUpInside)
        zeroButton.addTarget(self, action: #selector(returnButtonValue), for: .touchUpInside)
        enterButton.addTarget(self, action: #selector(returnButtonValue), for: .touchUpInside)
        
        
        fourthRow.addArrangedSubview(deleteButton)
        fourthRow.addArrangedSubview(zeroButton)
        fourthRow.addArrangedSubview(enterButton)
        
        fourthRow.translatesAutoresizingMaskIntoConstraints = false
        fourthRow.axis = .horizontal
        fourthRow.distribution = .fillEqually
        
    }
    
    @objc func returnButtonValue(_ sender: UIButton ) {
//        print(sender.currentTitle!)
        delegate.getButtonLabel(buttonName: sender.currentTitle!)
        sender.flash()
    }
    

}
