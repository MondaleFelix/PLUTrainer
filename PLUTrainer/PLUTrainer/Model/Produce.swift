//
//  Produce.swift
//  PLUTrainer
//
//  Created by Mondale on 1/7/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import Foundation

struct Produce : Equatable {
    let name: String
    let plu: String
    
    init(name: String, plu: String){
        self.name = name
        self.plu = plu
    }
}
