//
//  IshiharaQuestion.swift
//  PsychoTestsAR
//
//  Created by Mateusz Januszko on 18/04/2019.
//  Copyright © 2019 PUMTeam. All rights reserved.
//

import Foundation

class IshiharaQuestion {
    let optionA: String
    let optionB: String
    let optionC: String
    let optionD: String
    
    let questionImage: String
    let question: String
    let correctAnswer: Int
    
    init(image: String, questionText: String, choiceA: String, choiceB: String, choiceC: String, choiceD: String, answer: Int) {
        questionImage = image
        question = questionText
        optionA = choiceA
        optionB = choiceB
        optionC = choiceC
        optionD = choiceD
        correctAnswer = answer
    }
    
}
