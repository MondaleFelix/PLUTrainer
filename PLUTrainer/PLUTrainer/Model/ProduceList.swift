//
//  ProduceList.swift
//  PLUTrainer
//
//  Created by Mondale on 1/22/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class ProduceList  {

    static let sharedInstance = ProduceList()

    var pluList = [
        ProduceOLD(image: UIImage.init(named: "banana")!, name: "banana", plu: "94011"),
        ProduceOLD(image: UIImage.init(named: "lime")!, name: "lime", plu: "94048"),
        ProduceOLD(image: UIImage.init(named: "lemon")!, name: "lemon", plu: "94958"),
        ProduceOLD(image: UIImage.init(named: "orange")!, name: "orange", plu: "93107")
    ]



    func deleteProduce(_ produce: ProduceOLD){
        
        if let deleteIndex = self.pluList.firstIndex(of: produce) {
            self.pluList.remove(at: deleteIndex)
        }
    }

    func addProduce(_ produce: ProduceOLD){
        self.pluList.append(produce)
    }


}
