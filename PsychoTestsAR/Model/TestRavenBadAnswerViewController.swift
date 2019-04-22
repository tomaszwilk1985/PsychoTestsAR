//
//  TestRavenBadAnswerViewController.swift
//  PsychoTestsAR
//
//  Created by Mariola Roznaska on 16/04/2019.
//  Copyright © 2019 PUMTeam. All rights reserved.
//

import UIKit

class TestRavenBadAnswerViewController: UIViewController {
    
    let allQuestions = RavenQuestionBank()
    var questionNumber : Int = 0
    
    let userDataTests = UserDefaults.standard
    
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var questionImage: UIImageView!
    
    @IBOutlet weak var buttonBadAnswer: UIButton!
    @IBOutlet weak var buttonRightAnswer: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var nrQuestionBad = [Int]()
    var badAnswer = [Int]()
    var nrQuestionRandom = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nrQuestionBad = userDataTests.array(forKey: "nrQuestBadAnserList") as? [Int] ?? [Int]()
        badAnswer = userDataTests.array(forKey:"badAnserList") as? [Int] ?? [Int]()
        nrQuestionRandom = userDataTests.array(forKey: "nrQuestRadomList") as? [Int] ?? [Int]()
        
        print("Bad Answer nrQuestionRandom: \(nrQuestionRandom)")
        nextQuestion()
        // Do any additional setup after loading the view.
    }
    
    let abc = ["X","A","B","C","D","E","F","G","H"]
    var correctAnswer: Int = 0
    
    func nextQuestion(){
        
        if questionNumber < nrQuestionBad.count {
            
            progressLabel.text = "Pytanie: \(nrQuestionRandom[questionNumber]+1) / 20"
          
            questionImage.image = UIImage(named: "test-de-raven-\(String(nrQuestionBad[questionNumber]))_bg")
            
            buttonBadAnswer.setImage(UIImage(named: "test-de-raven-\(String(nrQuestionBad[questionNumber]))_\(abc[badAnswer[questionNumber]])"), for: .normal)
            
            for item in allQuestions.list {
                if  item.nrQuestion == nrQuestionBad[questionNumber] {
                    correctAnswer = item.answer
                }
            }
            
            buttonRightAnswer.setImage(UIImage(named: "test-de-raven-\(String(nrQuestionBad[questionNumber]))_\(abc[correctAnswer])"), for: .normal)
            
            questionNumber = questionNumber + 1
        }
        else{
            nextButton.setTitle("Zakończ", for: .normal)
            
        }
        
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        nextQuestion()
        
        if nextButton.title(for: .normal) == "Zakończ" {
            performSegue(withIdentifier: "back", sender: self)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
