//
//  ProduceTableViewCell.swift
//  PLUTrainer
//
//  Created by Mondale on 7/24/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class ProduceTableViewCell: UITableViewCell {

    static let reuseID = "ProduceCell"

    
    let produceLabel = UILabel()
    let pluCode = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 15, left: 10, bottom: 0 , right: 10))
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        contentView.addSubview(produceLabel)
        contentView.addSubview(pluCode)
        contentView.layer.cornerRadius = 10

        selectionStyle = .none

        contentView.backgroundColor = .systemBlue
        
        produceLabel.translatesAutoresizingMaskIntoConstraints = false
        produceLabel.font = UIFont(name: "SFProDisplay-Regular", size: 24)
        produceLabel.textColor = .white
        
        
        pluCode.translatesAutoresizingMaskIntoConstraints = false
        pluCode.textAlignment = .right
        pluCode.font = UIFont(name: "SFProDisplay-Regular", size: 24)
        pluCode.textColor = .white


        
        NSLayoutConstraint.activate([
            
            produceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            produceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            produceLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width/2 - 10),
            produceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            pluCode.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            pluCode.widthAnchor.constraint(equalToConstant: contentView.frame.width/2 - 10),
            pluCode.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            pluCode.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            
        ])
    }
}
