//
//  TestIQController.swift
//  PsychoTestsAR
//
//  Created by AT Wolfar on 03/04/2019.
//  Copyright © 2019 PUMTeam. All rights reserved.
//

import UIKit
import AudioToolbox

class TestIQController: UIViewController {
    
    let userDataIQTests = UserDefaults.standard
    
    var pointsResult: Int = 0
    var questionNumber: Int = 0
    var pickedAnser: Int = 0
    
    // Timer
    let time_limit: Int = 20
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var answerA: UIButton!
    @IBOutlet weak var answerB: UIButton!
    @IBOutlet weak var answerC: UIButton!
    
    var arrayQuestion = [String]()
    var arrayAnswer = [String]()
    var arrayValue = [String]()
    
    @IBOutlet weak var progressView: UIProgressView!
    
    
    let user_data_tests = UserDefaults.standard
    
    let progress = Progress(totalUnitCount: 10)
    
    var transform : CGAffineTransform = CGAffineTransform(scaleX: 1.0, y: 6.0)
    //  progressView.transform = transform
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        answerA.layer.cornerRadius = 30
        answerB.layer.cornerRadius = 30
        answerC.layer.cornerRadius = 30
        
        progressView.transform = transform
        
        progressView.layer.cornerRadius = 30
        
        progressView.progress = 0.0
        progress.completedUnitCount = 0
        
        
        
        arrayQuestion = user_data_tests.array(forKey: "questions") as? [String] ?? [String]()
        arrayAnswer = user_data_tests.array(forKey: "answers") as? [String] ?? [String]()
        arrayValue = user_data_tests.array(forKey: "values") as? [String] ?? [String]()
        
        nextQuestion()
        //    startTimer()
        
    }
    
    
    @IBAction func answerPressed(_ sender: AnyObject) {
        
        pickedAnser = Int(arrayValue[questionNumber * 3 + sender.tag])!
        
        checkAnswer()
        questionNumber = questionNumber + 1
        print("answerPressed \(questionNumber)")
        //    endTimer()
        //    startTimer()
        nextQuestion()
        
    }
    
    
    func updateUI() {
        
        // scoreLabel.text = "Punkty: \(pointsResult)"
        progressLabel.text = "Pytanie: \(questionNumber + 1) / 10"
        progress.completedUnitCount += 1
        progressView.setProgress(Float(self.progress.fractionCompleted), animated: true)
        
    }
    
    
    func nextQuestion() {
        
        if questionNumber  < 10{
            
            StopTimmerTestIQ ()
            StartTimmerTestIQ(time_limit: 20, output: timerLabel)
            
            questionLabel.text = arrayQuestion[questionNumber]
            //wyszukanie wlasciwych odpowiedzi do pytania w tablicy
            let answerNumber = questionNumber * 3
            answerA.setTitle(arrayAnswer[answerNumber + 0], for: .normal)
            answerB.setTitle(arrayAnswer[answerNumber + 1], for: .normal)
            answerC.setTitle(arrayAnswer[answerNumber + 2], for: .normal)
            
            updateUI()
            
        }
        else{
            SaveResultAndGoToNextVC()
        }
        
    }
    
    func checkAnswer() {
        
        if pickedAnser == 1{
            
            //     ProgressHUD.showSuccess("Correct")
            
            print("You got it!")
            pointsResult += 1
        }else{
            print("blad")
            //  ProgressHUD.showError("Wrong!")
        }
    }
    
    // Kod timera ---------------------------------------------
    var timmerTest: Timer? = nil
    
    
    func StopTimmerTestIQ () {
        timmerTest?.invalidate()
        timmerTest = nil
    }
    
    func StartTimmerTestIQ (time_limit: Int, output: UILabel) -> Void {
        var countStart = time_limit
        output.text = String (countStart)
        timmerTest = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {
            timmer in
            countStart -= 1
            output.text = String (countStart)
            
            if countStart == 0 {
                timmer.invalidate()
                
                if self.questionNumber >= 9 {
                    self.SaveResultAndGoToNextVC()
                    self.StopTimmerTestIQ()
                    print("wyjscie z formatki")
                }
                else{
                    self.questionNumber += 1
                    print("starTimmer \(self.questionNumber)")
                    self.nextQuestion()
                }
            }
        })
    }
    
    // --------------------------------------------------------------
    
    
    
    //przeniesienie wyniku testu na formatke resultTest
    func SaveResultAndGoToNextVC () -> Void {
        let userSave = UserDefaults.standard
        userSave.set(pointsResult, forKey: "scoreResult")
        userSave.set(1, forKey: "nrTest")
        performSegue(withIdentifier: "resultTestIQ", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
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
