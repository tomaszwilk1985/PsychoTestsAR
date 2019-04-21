//
//  TestIshiharaController.swift
//  PsychoTestsAR
//
//  Created by AT Wolfar on 03/04/2019.
//  Copyright © 2019 PUMTeam. All rights reserved.
//

import UIKit

class TestIshiharaController: UIViewController {
    @IBOutlet weak var questionCounter: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressLabel: UIView!
    @IBOutlet weak var ishiharaView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    
    //Outlet for Buttons
    
    @IBOutlet weak var optionA: UIButton!
    @IBOutlet weak var optionB: UIButton!
    @IBOutlet weak var optionC: UIButton!
    @IBOutlet weak var optionD: UIButton!
    
    var allQuestions = IshiharaQuestionBank()
    var questionNumber: Int = 0
    var scored: Int = 0
    var selectedAnswer: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StartTimmer(time_limit: 10, output: timerLabel)
        updateQuestion()
        updateUI()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func answerPressed(_ sender: UIButton) {
        
        if sender.tag == selectedAnswer {
            print("correct")
            scored += 1
        } else {
            print("wrong")
        }
        

        questionNumber += 1
        updateQuestion()


        
        
    }
    
    func updateQuestion() {
        
        
        if questionNumber < 10 {
            
            ishiharaView.image = UIImage(named:(allQuestions.list[questionNumber].questionImage))
            questionLabel.text = allQuestions.list[questionNumber].question
            optionA.setTitle(allQuestions.list[questionNumber].optionA, for: UIControl.State.normal)
            optionB.setTitle(allQuestions.list[questionNumber].optionB, for: UIControl.State.normal)
            optionC.setTitle(allQuestions.list[questionNumber].optionC, for: UIControl.State.normal)
            optionD.setTitle(allQuestions.list[questionNumber].optionD, for: UIControl.State.normal)
            selectedAnswer = allQuestions.list[questionNumber].correctAnswer
            StopTimmer()
            StartTimmer(time_limit: 10, output: timerLabel)


            
        } else {
            SaveResultAndGoToNextVC()
        }
        updateUI()
        
    }
    
    func updateUI() {
        
        if questionNumber < 10 {
            scoreLabel.text = "score: \(scored)"
            questionCounter.text = "\(questionNumber + 1)/10"
            progressLabel.frame.size.width = (view.frame.size.width / CGFloat(10) * CGFloat(questionNumber + 1))
        }
        
    }
    
    func restartQuiz() {
        
        scored = 0
        questionNumber = 0
        updateQuestion()
        allQuestions = IshiharaQuestionBank()

        
        
        
        
        
    }
    
    var timmerTest: Timer? = nil
    
    
    func StopTimmer () {
        timmerTest?.invalidate()
        timmerTest = nil
    }
    
    func StartTimmer (time_limit: Int, output: UILabel) -> Void {
        var countStart = time_limit
        output.text = String (countStart)
        timmerTest = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {
            timmer in
            countStart -= 1
            output.text = String (countStart)
            
            if countStart == 0 {
                timmer.invalidate()
                let alert = UIAlertController(title: "Koniec czasu", message: "Sprobuj jeszcze raz", preferredStyle: .alert)
                let restartAction = UIAlertAction(title: "Restart", style: .default, handler: {action in self.restartQuiz()})
                alert.addAction(restartAction)
                self.present(alert, animated: true, completion: nil)
                
                
            }
        })
    }
    
    func SaveResultAndGoToNextVC () -> Void {
        let userSave = UserDefaults.standard
        userSave.set(scored, forKey: "scoreResult")
        userSave.set(2, forKey: "nrTest")
        performSegue(withIdentifier: "IsharaResultView", sender: self)
    }
    
    override var shouldAutorotate: Bool {
        if UIDevice.current.orientation.isLandscape == false {
            return true
        }
        else {
            return false
        }
        
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


