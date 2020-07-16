//
//  ViewController.swift
//  PLUTrainer
//
//  Created by Mondale on 1/7/20.
//  Copyright © 2020 Mondale. All rights reserved.

import UIKit
import CoreData

class QuizVC: UIViewController, UITextFieldDelegate, ReturnButtonNameDelegate {

    var coreData = CoreDataStack()
    var quiz = Quiz.sharedInstance
    
    var stackView = UIStackView()
    var foodImage = UIImageView()
    var foodLabel = UILabel()
    var pluLabel = UILabel()
    var keyboard = Keyboard()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTest()
        configure()
        configureStackView()
        updateUI2()
        keyboard.delegate = self
    }
    
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
    

    
    
    private func fetchTest() {
        self.coreData.fetchPersistedData { (fetchItemsResult) in
            switch fetchItemsResult {
            case let .success(items):
                print(items)
                for item in items {
//                    var newItem = ProduceOLD(image: UIImage(data: item.image!)!, name: item.name, plu: item.plu)
//                    self.quiz.quiz.append(newItem)
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
        foodImage.contentMode = .scaleAspectFit
        foodImage.backgroundColor = .red
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        
        keyboard.translatesAutoresizingMaskIntoConstraints = false
        
        pluLabel.translatesAutoresizingMaskIntoConstraints = false
        pluLabel.textAlignment = .center
        
        foodLabel.translatesAutoresizingMaskIntoConstraints = false
        foodLabel.textAlignment = .center
        

    }
    
    
//    @objc func checkButtonTapped() {
//        let userAnswer = pluLabel.text!
//        let correctAnswer = quiz.checkAnswer(userAnswer)
//        
//        if correctAnswer {
//            self.view.backgroundColor = .green
//        } else {
//            self.view.backgroundColor = .red
//        }
//        
//    }
    
    
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
            [stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0),
             stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
             
        ])
    }

    func updateUI2() {
        let produce = quiz.getFood()
        
        pluLabel.text = quiz.getUserInput()
        foodLabel.text = produce.name
        foodImage.image = produce.image
        self.view.backgroundColor = .white
        
    }
    

//    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
//        quiz.quiz = pluList.pluList
//        updateUI()
//    }
    
//    @IBAction func deleteButtonPressed(_ sender: UIButton) {
//        quiz.deleteNumber()
//        updateUI()
//    }
//
//    @objc func submitButtonPressed(_ sender: UIButton) {
//        let userAnswer = pluLabel.text!
//        let correctAnswer = quiz.checkAnswer(userAnswer)
//
//        if correctAnswer {
//            self.view.backgroundColor = .green
//        } else {
//            self.view.backgroundColor = .red
//        }
//
//
//        quiz.clearUserInput()
//        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats:  false)
//    }
//
    
    // Grabs the produce from current quiz question

    @objc func updateUI(){
        
        let produce = quiz.getFood()
        pluLabel.text = quiz.getUserInput()
        foodLabel.text = produce.plu
        foodImage.image = produce.image
        self.view.backgroundColor = .white
    }
    
}

