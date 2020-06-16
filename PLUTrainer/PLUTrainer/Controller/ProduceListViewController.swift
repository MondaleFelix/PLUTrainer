//
//  ProduceListViewController.swift
//  PLUTrainer
//
//  Created by Mondale on 1/9/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class ProduceListViewController: UIViewController {
    
    var table: UITableView = {
        let newTable = UITableView()
        newTable.translatesAutoresizingMaskIntoConstraints = false
        return newTable
    }()
    
    var produceList: [Produce] = []
//    var names: [String] = ["ME", "you", "we"]
    
    let data = ProduceList.sharedInstance
    let quizList = Quiz.sharedInstance
    
//    required init?(coder aDecoder: NSCoder) {
//        let data = ProduceList.sharedInstance
//        produceList = data.pluList
//        super.init(coder: aDecoder)
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Produce List"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        configureTable()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//            tableView.reloadData()
//
//    }
    
    
    // Protocol Methods
    // Determines the number of cells to return
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.pluList.count
//
//    }
    
    func configureTable() {
        self.view.addSubview(table)
        self.table.delegate = self
        self.table.dataSource = self
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
//        self.table.frame = view.bounds
        NSLayoutConstraint.activate([
            self.table.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            self.table.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            self.table.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            self.table.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),


        ])
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ProduceItem", for: indexPath)
//        let item = data.pluList[indexPath.row]
//
//
//        let namelabel = cell.viewWithTag(1000) as! UILabel
//        namelabel.text = item.name
//
//        let codeLabel = cell.viewWithTag(1001) as! UILabel
//        codeLabel.text = item.plu
//
//        return cell
//    }

    // Enables swipe deletion 
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        let produceItem = data.pluList[indexPath.row]
//
//        data.deleteProduce(produceItem)
//        quizList.deleteProduce(produceItem)
//        tableView.reloadData()
//
//    }
}

extension ProduceListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.pluList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let produce = data.pluList[indexPath.row]
        cell.textLabel!.text = produce.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let produceItem = data.pluList[indexPath.row]
        
        data.deleteProduce(produceItem)
        quizList.deleteProduce(produceItem)
        table.reloadData()
    }
    
    
}
