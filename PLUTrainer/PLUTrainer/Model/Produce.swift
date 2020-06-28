//
//  Produce.swift
//  PLUTrainer
//
//  Created by Mondale on 1/7/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import Foundation
import UIKit

struct ProduceOLD : Equatable {
    let image: UIImage
    let name: String
    let plu: String
    
    init(image: UIImage, name: String, plu: String){
        self.image = image
        self.name = name
        self.plu = plu
    }
}
