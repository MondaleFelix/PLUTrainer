//
//  Quiz.swift
//  PLUTrainer
//
//  Created by Mondale on 1/7/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import Foundation
import UIKit

class Quiz {


    static let sharedInstance = Quiz()

    var quiz = [
        ProduceOLD(image: UIImage.init(named: "banana")!, name: "banana", plu: "94011"),
        ProduceOLD(image: UIImage.init(named: "lime")!, name: "lime", plu: "94048"),
        ProduceOLD(image: UIImage.init(named: "lemon")!, name: "lemon", plu: "94958"),
        ProduceOLD(image: UIImage.init(named: "orange")!, name: "ornage", plu: "93107"),

    ]



    var userInput = [String]()

    func addNumber(_ number: String) {
        self.userInput.append(number)
    }

    func deleteNumber(){
        self.userInput.popLast()
    }

    func clearUserInput(){
        self.userInput.removeAll()
    }

    func checkAnswer(_ userAnswer:String) -> Bool {

        if userAnswer == quiz[0].plu {
            self.quiz.removeFirst()
            return true
        } else {
            self.quiz.append(self.quiz.removeFirst())
            return false
        }
    }

    func getUserInput() -> String {
        return userInput.joined()
    }

    func getFood() -> ProduceOLD {
        return quiz[0]
    }

    func addProduce(_ produce: ProduceOLD){
        self.quiz.append(produce)
    }

    func deleteProduce(_ produce: ProduceOLD){

        if let deleteIndex = self.quiz.firstIndex(of: produce) {
            self.quiz.remove(at: deleteIndex)
        }
    }

}
