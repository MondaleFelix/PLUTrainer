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
    
    var quiz = Quiz()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
    @IBAction func keyboardButtonPressed(_ sender: UIButton) {
        
        let numPressed = sender.currentTitle!
        
        if pluLabel.text!.count < 5 {
            quiz.addNumber(numPressed)
            updateUI()
        }

    }
    

    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        quiz.deleteNumber()
        updateUI()
    }
    
    func updateUI(){
        pluLabel.text = quiz.getUserInput()
    }

}
