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
        addBarButton()
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
    
    
    private func addBarButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: .done, target: self, action: #selector(newButtonPressed))
    }
    
    
    @objc func newButtonPressed(){
        navigationController?.pushViewController(AddProduceViewController2(), animated: true)
        
    }
    
    
    // Sets View's UI
    private func configure(){
        title = "Produce"
        view.backgroundColor = .white
    }
    
    
    // Sets up Produce Table View
    private func configureTable() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProduceTableViewCell.self, forCellReuseIdentifier: ProduceTableViewCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 75
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.allowsSelectionDuringEditing = true


        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    
}

extension ProduceListViewController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProduceTableViewCell.reuseID, for: indexPath) as! ProduceTableViewCell
        let produce = produceList[indexPath.row]
        cell.produceLabel.text = produce.name
        cell.pluCode.text = produce.plu
        return cell
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

extension ProduceListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let produceDetailPage = ProduceDetailVC()
        produceDetailPage.produceItem = produceList[indexPath.row]
        self.present(produceDetailPage, animated: true, completion: nil)
    }
    
}

