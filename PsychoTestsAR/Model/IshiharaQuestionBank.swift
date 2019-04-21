//
//  IshiharaQuestionBank.swift
//  PsychoTestsAR
//
//  Created by Mateusz Januszko on 18/04/2019.
//  Copyright © 2019 PUMTeam. All rights reserved.
//

import Foundation

class IshiharaQuestionBank {
    var list = [IshiharaQuestion]()
    
    init() {
        
        list.append(IshiharaQuestion(image: "ishihara2", questionText: "Jaką widzisz liczbę?", choiceA: "2", choiceB: "3", choiceC: "4", choiceD: "Nie wiem", answer: 1))
        
        list.append(IshiharaQuestion(image: "ishihara3", questionText: "Jaką widzisz liczbę?", choiceA: "3", choiceB: "4", choiceC: "7", choiceD: "Nie wiem", answer: 1))
        
        list.append(IshiharaQuestion(image: "ishihara5", questionText: "Jaką widzisz liczbę?", choiceA: "2", choiceB: "3", choiceC: "5", choiceD: "7", answer: 3))
        
        list.append(IshiharaQuestion(image: "ishihara6", questionText: "Jaką widzisz liczbę?", choiceA: "2", choiceB: "3", choiceC: "6", choiceD: "9", answer: 3))
        
        list.append(IshiharaQuestion(image: "ishihara7", questionText: "Jaką widzisz liczbę?", choiceA: "2", choiceB: "3", choiceC: "7", choiceD: "9", answer: 3))
        
        list.append(IshiharaQuestion(image: "ishihara8", questionText: "Jaką widzisz liczbę?", choiceA: "2", choiceB: "6", choiceC: "7", choiceD: "8", answer: 4))
        
        list.append(IshiharaQuestion(image: "ishihara12", questionText: "Jaką widzisz liczbę?", choiceA: "12", choiceB: "13", choiceC: "17", choiceD: "Nie wiem", answer: 1))
        
        list.append(IshiharaQuestion(image: "ishihara15", questionText: "Jaką widzisz liczbę?", choiceA: "12", choiceB: "13", choiceC: "15", choiceD: "Nie wiem", answer: 3))
        
        list.append(IshiharaQuestion(image: "ishihara16", questionText: "Jaką widzisz liczbę?", choiceA: "6", choiceB: "16", choiceC: "19", choiceD: "Nie wiem", answer: 2))
        
        list.append(IshiharaQuestion(image: "ishihara26", questionText: "Jaką widzisz liczbę?", choiceA: "16", choiceB: "26", choiceC: "36", choiceD: "46", answer: 2))
        
        list.append(IshiharaQuestion(image: "ishihara29", questionText: "Jaką widzisz liczbę?", choiceA: "28", choiceB: "29", choiceC: "39", choiceD: "Nie wiem", answer: 2))
        
        list.append(IshiharaQuestion(image: "ishihara42", questionText: "Jaką widzisz liczbę?", choiceA: "42", choiceB: "44", choiceC: "46", choiceD: "Nie wiem", answer: 1))
        
        list.append(IshiharaQuestion(image: "ishihara45", questionText: "Jaką widzisz liczbę?", choiceA: "40", choiceB: "45", choiceC: "49", choiceD: "Nie wiem", answer: 2))
        
        list.append(IshiharaQuestion(image: "ishihara73", questionText: "Jaką widzisz liczbę?", choiceA: "2", choiceB: "3", choiceC: "7", choiceD: "73", answer: 4))
        
        list.append(IshiharaQuestion(image: "ishihara74", questionText: "Jaką widzisz liczbę?", choiceA: "72", choiceB: "74", choiceC: "77", choiceD: "Nie wiem", answer: 2))
        
        list.append(IshiharaQuestion(image: "ishihara9", questionText: "Jaką widzisz liczbę?", choiceA: "3", choiceB: "6", choiceC: "9", choiceD: "Nie wiem", answer: 3))
        
        list.append(IshiharaQuestion(image: "ishihara14", questionText: "Jaką widzisz liczbę?", choiceA: "13", choiceB: "14", choiceC: "17", choiceD: "Nie wiem", answer: 2))
        
        list.append(IshiharaQuestion(image: "ishihara35", questionText: "Jaką widzisz liczbę?", choiceA: "33", choiceB: "34", choiceC: "35", choiceD: "Nie wiem", answer: 3))
        
        list.append(IshiharaQuestion(image: "ishihara57", questionText: "Jaką widzisz liczbę?", choiceA: "55", choiceB: "57", choiceC: "59", choiceD: "Nie wiem", answer: 2))
        
        list.append(IshiharaQuestion(image: "ishihara96", questionText: "Jaką widzisz liczbę?", choiceA: "93", choiceB: "96", choiceC: "99", choiceD: "Nie wiem", answer: 2))
        
        list.append(IshiharaQuestion(image: "ishihara97", questionText: "Jaką widzisz liczbę?", choiceA: "93", choiceB: "96", choiceC: "97", choiceD: "Nie wiem", answer: 3))
        
        list.append(IshiharaQuestion(image: "niewiem1", questionText: "Jaką widzisz liczbę?", choiceA: "1", choiceB: "3", choiceC: "7", choiceD: "Nie wiem", answer: 4))
        
        list.append(IshiharaQuestion(image: "niewiem2", questionText: "Jaką widzisz liczbę?", choiceA: "2", choiceB: "3", choiceC: "17", choiceD: "Nie wiem", answer: 4))
        
        list.append(IshiharaQuestion(image: "niewiem3", questionText: "Jaką widzisz liczbę?", choiceA: "12", choiceB: "13", choiceC: "17", choiceD: "Nie wiem", answer: 4))
        
        list.append(IshiharaQuestion(image: "niewiem4", questionText: "Jaką widzisz liczbę?", choiceA: "11", choiceB: "14", choiceC: "36", choiceD: "Nie wiem", answer: 4))
        
        list.append(IshiharaQuestion(image: "niewiem5", questionText: "Jaką widzisz liczbę?", choiceA: "2", choiceB: "3", choiceC: "7", choiceD: "Nie wiem", answer: 4))
        
        list.append(IshiharaQuestion(image: "niewiem6", questionText: "Jaką widzisz liczbę?", choiceA: "6", choiceB: "8", choiceC: "10", choiceD: "Nie wiem", answer: 4))
        
        list = list.shuffled()
    }
    
}

