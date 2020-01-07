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
    
    var userInput = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func keyboardButtonPressed(_ sender: UIButton) {
        userInput.append(sender.currentTitle!)
        updateUI()
    }
    

    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        userInput.popLast()
        updateUI()
    }
    
    func updateUI(){
        pluLabel.text = userInput.joined()
    }

}
