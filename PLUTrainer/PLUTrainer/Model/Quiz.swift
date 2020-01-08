//
//  Quiz.swift
//  PLUTrainer
//
//  Created by Mondale on 1/7/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import Foundation

struct Quiz {
    
    var quiz = [
        Produce(name: "banana", plu: "94011"),
        Produce(name: "lime", plu: "94048"),
        Produce(name: "lemon", plu: "94958"),
        Produce(name: "orange", plu: "93107")
    ]
    
    var userInput = [String]()

    mutating func addNumber(_ number: String) {
        self.userInput.append(number)
    }
 
    mutating func deleteNumber(){
        self.userInput.popLast()
    }
    
    mutating func clearUserInput(){
        self.userInput.removeAll()
    }
    
    mutating func checkAnswer(_ userAnswer:String) -> Bool {
        
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
    
    func getFood() -> String {
        return quiz[0].name
    }
    
    
}