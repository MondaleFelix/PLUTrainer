//
//  ProduceListViewController.swift
//  PLUTrainer
//
//  Created by Mondale on 1/9/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class ProduceListViewController: UITableViewController {
    
    var produceItems: [Produce]
    
    required init?(coder aDecoder: NSCoder) {
        let data = Quiz()
        produceItems = data.quiz
        

        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // Protocol Methods
    
    
    // Determines the number of cells to return
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produceItems.count

    }
    
    
    //
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProduceItem", for: indexPath)
        let item = produceItems[indexPath.row]
        
        
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.name
        
        return cell
    }
}
