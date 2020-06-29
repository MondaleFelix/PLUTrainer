//
//  ViewController.swift
//  PLUTrainer
//
//  Created by Mondale on 1/7/20.
//  Copyright © 2020 Mondale. All rights reserved.
// The orange is messing it up

import UIKit
import CoreData

class QuizVC: UIViewController, UITextFieldDelegate, ReturnButtonNameDelegate {
    func getButtonLabel(buttonName: String) {
        if buttonName == "del" {
            pluLabel.text! = String(pluLabel.text!.dropLast())
        } else if buttonName == "ent" {
            let correctAnswer = quiz.checkAnswer(pluLabel.text!)
            
            if correctAnswer {
                self.view.backgroundColor = .green
            } else {
                self.view.backgroundColor = .red
            }
            Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats:  false)
        } else {
            pluLabel.text! += buttonName
        }
    }
    
    var coreData = CoreDataStack()
    
    var quiz = Quiz.sharedInstance
    var pluList = ProduceList.sharedInstance
    
    var stackView = UIStackView()
    var foodImage = UIImageView()
    var foodLabel = UILabel()
    var pluLabel = UILabel()
    var keyboard = Keyboard()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureStackView()
        updateUI2()
        keyboard.delegate = self
        // if want to get location where application is stored
        //        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        //          let uiImage = UIImageView()
        //                        uiImage.image = UIImage(named: "banana")
        //                let produce1 = Produce(context: self.coreData.managedContext)
        //                        produce1.name = "test2"
        //                        produce1.plu = "testplucode2"
        //                        produce1.image = uiImage.image?.pngData()
        //                coreData.saveContext()
        fetchTest()
        
    }
    
    private func fetchTest() {
        self.coreData.fetchPersistedData { (fetchItemsResult) in
            switch fetchItemsResult {
            case let .success(items):
                print(items)
                for item in items {
                    print(item.name)
                    print(item.image)
                }
            case .failure(let error):
                print(error)
            }
            // reload the collection view's data source to present the current data set to the user
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    private func configure(){
        view.addSubview(foodImage)
        view.addSubview(foodLabel)
        view.addSubview(pluLabel)
        view.addSubview(keyboard)
        
        
        pluLabel.text = "Mondale"
        
        keyboard.translatesAutoresizingMaskIntoConstraints = false
        pluLabel.translatesAutoresizingMaskIntoConstraints = false
        pluLabel.textAlignment = .center
        
        foodLabel.translatesAutoresizingMaskIntoConstraints = false
        foodLabel.textAlignment = .center
        
        foodImage.contentMode = .scaleAspectFit
        foodImage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    @objc func checkButtonTapped() {
        let userAnswer = pluLabel.text!
        let correctAnswer = quiz.checkAnswer(userAnswer)
        
        if correctAnswer {
            self.view.backgroundColor = .green
        } else {
            self.view.backgroundColor = .red
        }
        
    }
    
    
    func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        
        
        stackView.addArrangedSubview(foodImage)
        stackView.addArrangedSubview(foodLabel)
        stackView.addArrangedSubview(pluLabel)
        stackView.addArrangedSubview(keyboard)
        NSLayoutConstraint.activate(
            [stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 2),
             stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 0)
        ])
    }
    
    func updateUI2() {
        let produce = quiz.getFood()
        
        pluLabel.text = quiz.getUserInput()
        foodLabel.text = produce.name
        foodImage.image = produce.image
        self.view.backgroundColor = .white
        
    }
    
    func updatePluInput(){
        
    }
    
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        quiz.quiz = pluList.pluList
        updateUI()
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        quiz.deleteNumber()
        updateUI()
    }
    
    @objc func submitButtonPressed(_ sender: UIButton) {
        let userAnswer = pluLabel.text!
        let correctAnswer = quiz.checkAnswer(userAnswer)
        
        if correctAnswer {
            self.view.backgroundColor = .green
        } else {
            self.view.backgroundColor = .red
        }
        
        
        quiz.clearUserInput()
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats:  false)
    }
    
    @objc func updateUI(){
        
        // Grabs the from produce from current quiz question
        let produce = quiz.getFood()
        pluLabel.text = quiz.getUserInput()
        foodLabel.text = produce.name
        foodImage.image = produce.image
        self.view.backgroundColor = .white
    }
    
}
