//
//  ProduceListViewController.swift
//  PLUTrainer
//
//  Created by Mondale on 1/9/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class ProduceListViewController: UIViewController {
    
    let quizList = Quiz.sharedInstance
    var coreData = CoreDataStack()
    
    var produceList: [Produce] = []
    let tableView = UITableView()


    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTable()
//        fetchProduce()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.fetchProduce()
            self.tableView.reloadData()
        }

    }
    
    
    private func fetchProduce() {
        self.coreData.fetchPersistedData { (fetchItemsResult) in
            switch fetchItemsResult {
            case let .success(items):
                self.produceList = items
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    // Sets View's UI
    private func configure(){
        title = "Produce"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
    }
    
    
    // Sets up Produce Table View
    private func configureTable() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
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
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        return produceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let produce = produceList[indexPath.row]
        cell.textLabel!.text = produce.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let produceDetailPage = ProduceDetailVC()
        produceDetailPage.produceItem = produceList[indexPath.row]
        self.present(produceDetailPage, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let produceItem = produceList[indexPath.row]
        self.coreData.managedContext.delete(produceItem)
        self.produceList.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
//        data.deleteProduce(produceItem)
//        quizList.deleteProduce(produceItem)
        self.coreData.saveContext()
        
        self.tableView.reloadData()
    }
    
    
}


