//
//  Question.swift
//  PsychoTestsAR
//
//  Created by Mariola Roznaska on 04/04/2019.
//  Copyright © 2019 PUMTeam. All rights reserved.
//

import Foundation

class RavenQuestion {
    
    let nrQuestion: Int
    let answerNrImg : String
    let answer: Int
    
    init(nrQuest: Int, answerImg: String, correctAnswer: Int){
        nrQuestion = nrQuest
        answerNrImg = answerImg
        answer = correctAnswer
    }
    
}

