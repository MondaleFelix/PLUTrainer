//
//  ViewController.swift
//  PLUTrainer
//
//  Created by Mondale on 1/7/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var pluLabel: UILabel!
    

    var quiz = Quiz.sharedInstance
    var pluList = ProduceList.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    
    @IBAction func keyboardButtonPressed(_ sender: UIButton) {
        
        let numberPressed = sender.currentTitle!
        
        // Limits the PLU Label to 5 characters
        if pluLabel.text!.count < 5 {
            quiz.addNumber(numberPressed)
            updateUI()
        }

    }
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        quiz.quiz = pluList.pluList
        updateUI()
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        quiz.deleteNumber()
        updateUI()
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
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
