//
//  ViewController.swift
//  PLUTrainer
//
//  Created by Mondale on 1/7/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    // Just testing this out
    
    //   @IBOutlet weak var foodImage: UIImageView!
    //    @IBOutlet weak var foodLabel: UILabel!
    //    @IBOutlet weak var pluLabel: UILabel!
    
    let foodImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let foodLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let pluLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    lazy var pluLabelInput: UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "PLU"
        textField.frame = CGRect(x:38, y: 100, width: 244, height: 30)
        //        textField.textAlignment = .center
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.keyboardType = .numberPad //keyboard type
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        
        textField.delegate = self
        return textField
    }()
    
    
    var quiz = Quiz.sharedInstance
    var pluList = ProduceList.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        createStackView()
        updateUI2()
        view.addSubview(pluLabelInput)
        addDoneButtonOnKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pluLabelInput.becomeFirstResponder()
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        print(sender.text!)
        
    }
    
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x:38, y: 100, width: 244, height: 30))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Enter", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.pluLabelInput.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.pluLabelInput.resignFirstResponder()
    }
    
    
    
    func createStackView() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(foodImage)
        stackView.addArrangedSubview(foodLabel)
        stackView.addArrangedSubview(pluLabel)
        NSLayoutConstraint.activate([stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 2),
                                     stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -250)
        ])
        
    }
    
    func updateUI2() {
        let produce = quiz.getFood()
        
        pluLabel.text = quiz.getUserInput()
        foodLabel.text = produce.name
        foodImage.image = produce.image
        self.view.backgroundColor = .white
        
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
        
        //        pluLabel.text = quiz.getUserInput()
        //       foodLabel.text = produce.name
        //       foodImage.image = produce.image
        //        self.view.backgroundColor = .white
    }
    
}
