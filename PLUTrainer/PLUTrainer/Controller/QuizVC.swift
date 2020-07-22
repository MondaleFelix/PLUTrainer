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
    var foodImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    var foodLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40.0)
        return label
    }()
    var pluLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30 )
        label.textColor = UIColor.gray
        label.textAlignment = .center
        return label
    }()
    var keyboard = Keyboard()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProduce()
        configure()
        configureStackView()
        updateUI2()
        keyboard.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .done, target: self, action: #selector(refreshButtonPressed))
    }
    
    @objc func refreshButtonPressed() {
        quiz.quiz = []
        self.fetchProduce()
        let alert = UIAlertController(title: "Quiz Refreshed", message: "Quiz has been reset", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getButtonLabel(buttonName: String) {
        if pluLabel.text == "Guess PLU Code" {
            pluLabel.text = ""
        }
        if buttonName == "del" {
            pluLabel.text! = String(pluLabel.text!.dropLast())
        } else if buttonName == "ent" {
            let correctAnswer = quiz.checkAnswer(pluLabel.text!)
            
            if correctAnswer {
                self.view.backgroundColor = .green
                self.pluLabel.text = "Correct!"
            } else {
                self.view.backgroundColor = .red
                self.pluLabel.text = "Incorrect!"
            }
            Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats:  false)
        } else {
            pluLabel.text! += buttonName
        }
    }
    
    private func fetchProduce() {
        self.coreData.fetchPersistedData { (fetchItemsResult) in
            switch fetchItemsResult {
            case let .success(items):
                for item in items {
                    let newItem = ProduceOLD(image: UIImage(data: item.image!)!, name: item.name, plu: item.plu)
                    self.quiz.quiz.append(newItem)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    private func configure(){
//        foodImage.contentMode = .scaleAspectFit
//        foodImage.backgroundColor = .red
//        foodImage.translatesAutoresizingMaskIntoConstraints = false
        
        keyboard.translatesAutoresizingMaskIntoConstraints = false
        
//        pluLabel.translatesAutoresizingMaskIntoConstraints = false
//        pluLabel.textAlignment = .center
        
        
        

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
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        
        NSLayoutConstraint.activate([
            foodImage.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            foodImage.heightAnchor.constraint(equalToConstant: 220)
        ])
        
        stackView.addArrangedSubview(foodImage)
        stackView.addArrangedSubview(foodLabel)
        stackView.addArrangedSubview(pluLabel)
        stackView.addArrangedSubview(keyboard)

        
        NSLayoutConstraint.activate([
             stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//             stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
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
        foodLabel.text = produce.name
        pluLabel.text = "Guess PLU Code"
        foodImage.image = produce.image
        self.view.backgroundColor = .white
    }
    
}

