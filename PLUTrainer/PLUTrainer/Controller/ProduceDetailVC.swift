//
//  ProduceDetailVC.swift
//  PLUTrainer
//
//  Created by Cao Mai on 6/28/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class ProduceDetailVC: UIViewController {
    
    var produceItem: Produce!
    var stackView = UIStackView()
    var foodImage = UIImageView()
    var foodLabel = UILabel()
    var pluLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.configure()
        self.configureStackView()
        self.configureProduceItem()
    }
    
    private func configure(){
        self.view.addSubview(foodImage)
        self.view.addSubview(foodLabel)
        self.view.addSubview(pluLabel)
        
            
        pluLabel.translatesAutoresizingMaskIntoConstraints = false
        pluLabel.textAlignment = .center
        
        foodLabel.translatesAutoresizingMaskIntoConstraints = false
        foodLabel.textAlignment = .center
        
        foodImage.contentMode = .scaleAspectFit
        foodImage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureStackView() {
        self.view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        
        
        stackView.addArrangedSubview(foodImage)
        stackView.addArrangedSubview(foodLabel)
        stackView.addArrangedSubview(pluLabel)
        NSLayoutConstraint.activate(
            [stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 2),
             stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 0)
        ])
    }
    
    func configureProduceItem() {
        self.foodImage.image = UIImage(data: produceItem.image!)
        self.foodLabel.text = produceItem.name
        self.pluLabel.text = produceItem.plu
    }
    

   

}
