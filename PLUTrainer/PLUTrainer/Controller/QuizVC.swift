//
//  ViewController.swift
//  PLUTrainer
//
//  Created by Mondale on 1/7/20.
//  Copyright © 2020 Mondale. All rights reserved.

import UIKit
import CoreData

class QuizVC: UIViewController, UITextFieldDelegate, ReturnButtonNameDelegate {

    func getButtonLabel(buttonDigits: String) {
        if buttonDigits == "ent" {
            let correctAnswer = quiz.checkAnswer(pluLabel.text!)
            feedBackImage.isHidden = false
            if correctAnswer {
//                self.view.backgroundColor = .green
                let checkmark = UIImage(systemName: "checkmark")!
                let checkmarkGreen = checkmark.withTintColor(.green, renderingMode: .alwaysOriginal)
                feedBackImage.image = checkmarkGreen
                pluLabel.text = "Correct!"
            } else {
//                self.view.backgroundColor = .red
                let xmark = UIImage(systemName: "xmark")!
                let xmarkRed = xmark.withTintColor(.red, renderingMode: .alwaysOriginal)
                feedBackImage.image = xmarkRed
                pluLabel.text = "Incorrect!"
            }
            Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(updateUI), userInfo: nil, repeats:  false)
        } else {
            pluLabel.text = buttonDigits
        }
    }
    
    var coreData = CoreDataStack()
    var quiz = Quiz.sharedInstance
    
    var foodImage = UIImageView()
    var feedBackImage = UIImageView()
    var foodLabel = UILabel()
    var pluLabel =  UILabel()
    var keyboard = Keyboard()
    var stackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProduce()
        configureUI()
        configureStackView()
        updateUI()
        addBarButtonItem()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
        
    }
    
    
    private func configureUI(){
        // Produce Image
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        foodImage.contentMode = .scaleAspectFit
        feedBackImage.translatesAutoresizingMaskIntoConstraints = false
        feedBackImage.contentMode = .scaleAspectFit
        feedBackImage.isHidden = true
        feedBackImage.layer.zPosition = 1;
        view.addSubview(feedBackImage)
               
        // Produce Label
        foodLabel.translatesAutoresizingMaskIntoConstraints = false
        foodLabel.textAlignment = .center
        foodLabel.font = UIFont(name: "SFProText-Light", size: 26)
        
        // Code Label
        pluLabel.translatesAutoresizingMaskIntoConstraints = false
        pluLabel.font = UIFont(name: "SFProText-Light", size: 36)
        pluLabel.textAlignment = .center
        
        keyboard.translatesAutoresizingMaskIntoConstraints = false
        keyboard.delegate = self
        
        NSLayoutConstraint.activate([
            foodImage.widthAnchor.constraint(equalToConstant: view.frame.width),
            foodImage.heightAnchor.constraint(equalToConstant: view.frame.height/4),
            
            keyboard.heightAnchor.constraint(equalToConstant: view.frame.height/3),
            
            feedBackImage.widthAnchor.constraint(equalToConstant: view.frame.width),
            feedBackImage.heightAnchor.constraint(equalToConstant: view.frame.height/4),
            feedBackImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5)

        ])
        
        
    }
    
    private func addBarButtonItem(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .done, target: self, action: #selector(refreshButtonPressed))
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
    
    @objc func refreshButtonPressed() {
        quiz.quiz = []
        self.fetchProduce()
        let alert = UIAlertController(title: "Quiz Refreshed", message: "Quiz has been reset", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        
        stackView.addArrangedSubview(foodImage)
        stackView.addArrangedSubview(foodLabel)
        stackView.addArrangedSubview(pluLabel)
        stackView.addArrangedSubview(keyboard)
        
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            
        ])
    }
    
    // Grabs the produce UI from model
    @objc func updateUI(){
        
        let produce = quiz.getFood()
        pluLabel.text = quiz.getUserInput()
        foodLabel.text = produce.name
        //        pluLabel.text = "94011"
        pluLabel.text = "PLU Code?"
        foodImage.image = produce.image
        self.view.backgroundColor = .white
        feedBackImage.isHidden = true
    }
    
    
    //    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
    //        quiz.quiz = pluList.pluList
    //        updateUI()
    //    }
    
    func deleteButtonPressed(_ sender: UIButton) {
        quiz.deleteNumber()
        updateUI()
    }
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
    
    
    
}

