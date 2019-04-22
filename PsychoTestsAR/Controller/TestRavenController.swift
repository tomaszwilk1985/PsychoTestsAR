//
//  TestRavenController.swift
//  PsychoTestsAR
//
//  Created by AT Wolfar on 03/04/2019.
//  Copyright © 2019 PUMTeam. All rights reserved.
//

import UIKit
import AudioToolbox

class TestRavenController: UIViewController {
    
    // Init default variables
    let allQuestions = RavenQuestionBank()
    var pickedAnser : Int = 0
    var questionNumber : Int = 0
    var score: Int = 0
    
    //zbieranie blednych odpowiedzi
    var nrQuestBadAnswer = [Int]()
    var badAnswer = [Int]()
    var nrQuestionRadom = [Int]()
    
    // Timer
    var countdownTimer: Timer! = nil
    var totalTime = 300
    
    //   let screenSize:CGRect = UIScreen.mainScreen().bounds
    
    @IBOutlet weak var progressLabel: UILabel!
    //    @IBOutlet weak var progressBar: UIView! = nil
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var questionImage: UIImageView!
    // Anser
    @IBOutlet weak var buttonAnswerA: UIButton!
    @IBOutlet weak var buttonAnswerB: UIButton!
    @IBOutlet weak var buttonAnswerC: UIButton!
    @IBOutlet weak var buttonAnswerD: UIButton!
    @IBOutlet weak var buttonAnswerE: UIButton!
    @IBOutlet weak var buttonAnswerF: UIButton!
    @IBOutlet weak var buttonAnswerG: UIButton!
    @IBOutlet weak var buttonAnswerH: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    //ilosc podzialek w progressView
    let progress = Progress(totalUnitCount: 20)
    //ustawienie wysokosci dla progressView
    var transform : CGAffineTransform = CGAffineTransform(scaleX: 1.0, y: 6.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressView.transform = transform
        progressView.progress = 0.0
        progress.completedUnitCount = 0
        
        allQuestions.list.shuffle()
        
        nextQuestion()
        startTimer()
    }
    
    
    func updateUI() {
        
        progressLabel.text = "Pytanie \(questionNumber + 1) / 20"
        progress.completedUnitCount += 1
        progressView.setProgress(Float(self.progress.fractionCompleted), animated: true)
        
    }
    
    
    @IBAction func answerPressed(_ sender: AnyObject) {
        
        pickedAnser = sender.tag
        checkAnswer()
        questionNumber = questionNumber + 1
        nextQuestion()
    }
    
    func checkAnswer() {
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if correctAnswer  == pickedAnser {
            score += 1
        }
        else{
            nrQuestBadAnswer.append(allQuestions.list[questionNumber].nrQuestion)
            badAnswer.append(pickedAnser)
            nrQuestionRadom.append(questionNumber)
        }
    }
    
    //restart testy
    func startOver() {
        
        questionNumber = 0
        score = 0
        nextQuestion()
        startTimer()
        
    }
    
    func nextQuestion() {
        
        buttonAnswerG.isHidden = false
        buttonAnswerH.isHidden = false
        
        
        
        if questionNumber  < 20{
            
            questionImage.image = UIImage(named: "test-de-raven-\(String(allQuestions.list[questionNumber].nrQuestion))_bg")
            
            buttonAnswerA.setImage(UIImage(named: "test-de-raven-\(String(allQuestions.list[questionNumber].nrQuestion))_A"), for: .normal)
            
            buttonAnswerB.setImage(UIImage(named: "test-de-raven-\(String(allQuestions.list[questionNumber].nrQuestion))_B"), for: .normal)
            
            buttonAnswerC.setImage(UIImage(named: "test-de-raven-\(String(allQuestions.list[questionNumber].nrQuestion))_C"), for: .normal)
            
            buttonAnswerD.setImage(UIImage(named: "test-de-raven-\(String(allQuestions.list[questionNumber].nrQuestion))_D"), for: .normal)
            
            buttonAnswerE.setImage(UIImage(named: "test-de-raven-\(String(allQuestions.list[questionNumber].nrQuestion))_E"), for: .normal)
            
            buttonAnswerF.setImage(UIImage(named: "test-de-raven-\(String(allQuestions.list[questionNumber].nrQuestion))_F"), for: .normal)
            
            if (allQuestions.list[questionNumber].answerNrImg == "F"){
                
                buttonAnswerG.isHidden = true
                buttonAnswerH.isHidden = true
                
            }else{
                
                buttonAnswerG.setImage(UIImage(named: "test-de-raven-\(String(allQuestions.list[questionNumber].nrQuestion))_G"), for: .normal)
                
                buttonAnswerH.setImage(UIImage(named: "test-de-raven-\(String(allQuestions.list[questionNumber].nrQuestion))_H"), for: .normal)
            }
            
            updateUI()
            
        }else{
            //przejdz do widoku z wynikami i przekaz dane
            SaveResultAndGoToNextVC()
            
        }
        
    }
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        timerLabel.text = "\(timeFormatted(totalTime))"
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
            
        }
    }
    
    func endTimer() {
        //wlacz wibracje
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        countdownTimer.invalidate()
        countdownTimer = nil
        //przenies na formatke z wynikami
        SaveResultAndGoToNextVC()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    //przeniesienie wyniku testu na formatke resultTest
    func SaveResultAndGoToNextVC () -> Void {
        let userSave = UserDefaults.standard
        userSave.set(score, forKey: "scoreResult")
        userSave.set(3, forKey: "nrTest")
        userSave.set(nrQuestBadAnswer, forKey: "nrQuestBadAnserList")
        userSave.set(badAnswer, forKey: "badAnserList")
        userSave.set(nrQuestionRadom, forKey: "nrQuestRadomList")
        performSegue(withIdentifier: "resultTest", sender: self)
    }
    
    
    
    //AUTOROTATION
    override var shouldAutorotate: Bool {
        if UIDevice.current.orientation.isLandscape == false {
            return true
        }
        else {
            return false
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
