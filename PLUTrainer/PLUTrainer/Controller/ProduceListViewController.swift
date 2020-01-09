//
//  ProduceListViewController.swift
//  PLUTrainer
//
//  Created by Mondale on 1/9/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class ProduceListViewController: UITableViewController {
    
    var items: [Produce]
    
    required init?(coder aDecoder: NSCoder) {
        items = [Produce]()
        let apple = Produce(name: "apple", plu: "90000")
        items.append(apple)
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // Protocol Methods
    
    
    // Determines the number of cells to return
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count

    }
    
    
    //
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProduceItem", for: indexPath)
        let item = items[indexPath.row]
        
        
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.name
        
        return cell
    }
}
