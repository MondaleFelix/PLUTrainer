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
    
    var foodImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    var foodLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40.0)
        return label
    }()
    var pluLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30 )
        label.textAlignment = .center
        label.textColor = UIColor.gray
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.configureStackView()
        self.configureProduceItem()
        self.view.backgroundColor = .white
    }
    
    private func configure(){
        self.view.addSubview(foodImage)
        self.view.addSubview(foodLabel)
        self.view.addSubview(pluLabel)
        
            
//        pluLabel.translatesAutoresizingMaskIntoConstraints = false
//        pluLabel.textAlignment = .center
//
//        foodLabel.translatesAutoresizingMaskIntoConstraints = false
//        foodLabel.textAlignment = .center
//
//        foodImage.contentMode = .scaleAspectFit
//        foodImage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureStackView() {
        self.view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        
        
        stackView.addArrangedSubview(foodImage)
        stackView.addArrangedSubview(foodLabel)
        stackView.addArrangedSubview(pluLabel)
        
        NSLayoutConstraint.activate([
            foodImage.widthAnchor.constraint(equalToConstant: 320),
            foodImage.heightAnchor.constraint(equalToConstant: 320)
        ])
        
        NSLayoutConstraint.activate([
//             stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 40),
             stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
             stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),

             stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -80)
        ])
    }
    
    func configureProduceItem() {
        self.foodImage.image = UIImage(data: produceItem.image!)
        self.foodLabel.text = produceItem.name
        self.pluLabel.text = "PLU: \(produceItem.plu)"
    }
    

   

}
