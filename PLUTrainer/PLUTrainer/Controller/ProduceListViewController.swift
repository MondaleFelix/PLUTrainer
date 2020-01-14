//
//  ProduceListViewController.swift
//  PLUTrainer
//
//  Created by Mondale on 1/9/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class ProduceListViewController: UITableViewController {
    
    var produceList: [Produce]
    
    

    
    let data = Quiz.sharedInstance
    
    
    required init?(coder aDecoder: NSCoder) {
        let data = Quiz.sharedInstance
        produceList = data.quiz
        
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
            tableView.reloadData()

    }
    // Protocol Methods
    // Determines the number of cells to return
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.quiz.count

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProduceItem", for: indexPath)
        let item = data.quiz[indexPath.row]
        
        
        let namelabel = cell.viewWithTag(1000) as! UILabel
        namelabel.text = item.name
        
        let codeLabel = cell.viewWithTag(1001) as! UILabel
        codeLabel.text = item.plu
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let produceItem = data.quiz[indexPath.row]
        
        data.deleteProduce(produceItem)
//        produceList.remove(at: indexPath.row)
        tableView.reloadData()
        
    }
}
