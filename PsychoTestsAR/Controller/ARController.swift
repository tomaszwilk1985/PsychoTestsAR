//
//  ARController.swift
//  PsychoTestsAR
//
//  Created by AT Wolfar on 21/03/2019.
//  Copyright © 2019 PUMTeam. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import Vision

class ARController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var sceneView: ARSCNView! // main scene
    @IBOutlet weak var debugConsole: UITextView! // ML detect params info
    @IBOutlet weak var symbolOverlay: UITextField! // ML detect object
    @IBOutlet weak var lblTimer: UILabel! // timer display
    @IBOutlet weak var lblCounter: UILabel! // count hits
    @IBOutlet weak var btnOkInfo: UIButton! // close info container
    @IBOutlet weak var scrollInfo: UIScrollView! // container for info
    @IBOutlet weak var txtInfo: UITextView! // info show
    @IBOutlet weak var imgStopWatch: UIImageView! // image scoreboard
    @IBOutlet weak var imgScoreboard: UIImageView! // image stopwatch
    @IBOutlet weak var lblChangeView: UITextField!
    
    //Scene properties
    var MyBox = SCNBox()
    var boxNode = SCNNode()
    var session = ARSession()
    var scene = SCNScene()
    
    //Timer properties
    var timer:Timer?
    var timeLeft = 3
    
    //Additional variables
    var hitCounter: Int = 0 // total hit count
    var objectToEnd: Int = 10
    var isStarted: Bool = false
    var currentDisplayObject = ""
    var currentMLRecognize = ""
    
    
    let dispatchQueueML = DispatchQueue(label: "com.hw.dispatchqueueml") // A Serial Queue
    var visionRequests = [VNRequest]()
    
    
    
    var mFirstStart = true
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        detectOrientation()
    }
    
    func detectOrientation() {
        if UIDevice.current.orientation.isLandscape {
            // print("Landscape")
            self.lblCounter.isHidden = false
            self.lblTimer.isHidden = false
            self.symbolOverlay.isHidden = false
            self.imgStopWatch.isHidden = false
            self.imgScoreboard.isHidden = false
            self.lblChangeView.isHidden = true
            
            if(isStarted){
                self.scrollInfo.isHidden = true
            }
            else
            {
                self.scrollInfo.isHidden = false
            }
            
        } else {
            // print("Portrait")
            self.lblChangeView.isHidden = false
            self.scrollInfo.isHidden = true
            self.lblCounter.isHidden = true
            self.lblTimer.isHidden = true
            self.symbolOverlay.isHidden = true
            self.imgStopWatch.isHidden = true
            self.imgScoreboard.isHidden = true
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        detectOrientation()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // --- ARKIT ---
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // --- ML & VISION ---
        
        // Setup Vision Model
        guard let selectedModel = try? VNCoreMLModel(for: hand_ml().model) else {
            fatalError("Could not load model. Ensure model has been drag and dropped (copied) to XCode Project. Also ensure the model is part of a target (see: https://stackoverflow.com/questions/45884085/model-is-not-part-of-any-target-add-the-model-to-a-target-to-enable-generation ")
        }
        
        // Set up Vision-CoreML Request
        let classificationRequest = VNCoreMLRequest(model: selectedModel, completionHandler: classificationCompleteHandler)
        classificationRequest.imageCropAndScaleOption = VNImageCropAndScaleOption.centerCrop // Crop from centre of images and scale to appropriate size.
        visionRequests = [classificationRequest]
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration, options: .resetTracking)
        mFirstStart = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
        objectToEnd = 10
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        DispatchQueue.main.async {
            // Do any desired updates to SceneKit here.
        }
    }
    
    // MARK: - MACHINE LEARNING
    
    func loopCoreMLUpdate() {
        if (isStarted) {
            // Continuously run CoreML whenever it's ready. (Preventing 'hiccups' in Frame Rate)
            dispatchQueueML.async {
                // 1. Run Update.
                self.updateCoreML()
                // 2. Loop this function.
                self.loopCoreMLUpdate()
            }
        }
    }
    
    func updateCoreML() {
        // Get Camera Image as RGB
        let pixbuff : CVPixelBuffer? = (sceneView.session.currentFrame?.capturedImage)
        if pixbuff == nil { return }
        let ciImage = CIImage(cvPixelBuffer: pixbuff!)
        
        // Prepare CoreML/Vision Request
        let imageRequestHandler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        
        // Run Vision Image Request
        do {
            try imageRequestHandler.perform(self.visionRequests)
        } catch {
            print(error)
        }
    }
    
    func classificationCompleteHandler(request: VNRequest, error: Error?) {
        // Catch Errors
        if error != nil {
            print("Error: " + (error?.localizedDescription)!)
            return
        }
        guard let observations = request.results else {
            print("No results")
            return
        }
        
        // Get Classifications
        let classifications = observations[0...2] // top 3 results
            .compactMap({ $0 as? VNClassificationObservation })
            .map({ "\($0.identifier) \(String(format:" : %.2f", $0.confidence))" })
            .joined(separator: "\n")
        
        // Render Classifications
        DispatchQueue.main.async {
            
            // Display Debug Text on screen
            self.debugConsole.text = "TOP 3 PROBABILITIES: \n" + classifications
            
            // Display Top Symbol
            var symbol = "❎"
            let topPrediction = classifications.components(separatedBy: "\n")[0]
            let topPredictionName = topPrediction.components(separatedBy: ":")[0].trimmingCharacters(in: .whitespaces)
            // Only display a prediction if confidence is above 1%
            let topPredictionScore:Float? = Float(topPrediction.components(separatedBy: ":")[1].trimmingCharacters(in: .whitespaces))
            if (topPredictionScore != nil && topPredictionScore! > 0.80) {
                if (topPredictionName == "hand_fist") { //hand_fist fist-UB-RHand
                    symbol = "👊"
                    self.currentMLRecognize = "fist"
                    self.onHitObject()
                }
                if (topPredictionName == "hand_open") { //hand_open FIVE-UB-RHand
                    symbol = "🖐"
                    self.currentMLRecognize = "open"
                    self.onHitObject()
                }
            }
            
            self.symbolOverlay.text = symbol
            
        }
    }
    
    
    
    @objc func onTimerEvents()
    {
        if (objectToEnd > 0)
        {
            timeLeft -= 1
            lblTimer.text = String(timeLeft)
            
            if timeLeft <= 0 {
                timeLeft = 3
                self.boxNode.isHidden = false
                //resetTracking()
                addMyBox(x:0,y:0,z:-0.5)
                objectToEnd -= 1
            }
        }
        else
        {
            self.scrollInfo.isHidden = false
            self.lblCounter.isHidden = true
            self.lblTimer.isHidden = true
            self.symbolOverlay.isHidden = true
            self.imgStopWatch.isHidden = true
            self.imgScoreboard.isHidden = true
            self.txtInfo.text = "Twój wynik to: " + lblCounter.text!
            
        }
        
    }
    
    
    func onHitObject()
    {
        if (self.boxNode.isHidden == false && isStarted == true)
        {
            if ((currentMLRecognize == "open" && currentDisplayObject == "green") || (currentMLRecognize == "fist" && currentDisplayObject == "red"))
            {
                hitCounter += 1
                lblCounter.text = String(hitCounter)
            }
            self.boxNode.isHidden = true
        }
    }
    
    
    /// ---- AR add object ----
    func addMyBox(x: Float = 0, y: Float = 0, z: Float = -0.2) {
        
        //restart boxNode
        self.boxNode.isHidden = false
        
        MyBox = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        
        var colors = [UIColor.green, // front
            UIColor.init(red: 0, green: 255, blue: 0, alpha: 0.5), // right
            UIColor.green, // back
            UIColor.green, // left
            UIColor.init(red: 0, green: 255, blue: 0, alpha: 0.5), // top
            UIColor.init(red: 0, green: 255, blue: 0, alpha: 0.5)] // bottom
        
        currentDisplayObject = "green"
        
        let number = Int.random(in: 1...2)
        
        if(number == 2)
        {
            colors = [UIColor.red, // front
                UIColor.init(red: 255, green: 0, blue: 0, alpha: 0.5), // right
                UIColor.red, // back
                UIColor.red, // left
                UIColor.init(red: 255, green: 0, blue: 0, alpha: 0.5), // top
                UIColor.init(red: 255, green: 0, blue: 0, alpha: 0.5)] // bottom
            
            currentDisplayObject = "red"
        }
        
        
        
        let sideMaterials = colors.map { color -> SCNMaterial in
            let material = SCNMaterial()
            material.diffuse.contents = color
            material.locksAmbientWithDiffuse = true
            return material
        }
        
        MyBox.materials = sideMaterials
        
        boxNode.geometry = MyBox
        boxNode.position = SCNVector3(x, y, z)
        boxNode.eulerAngles.x = boxNode.eulerAngles.x - 10
        boxNode.eulerAngles.y = boxNode.eulerAngles.y - 10
        
        scene.rootNode.addChildNode(boxNode)
        sceneView.scene = scene
        
    }
    
    
    
    @IBAction func hideInfoPanel(_ sender: UIButton) {
        
        if (objectToEnd > 0)
        {
            self.scrollInfo.isHidden = true
            self.lblCounter.isHidden = false
            self.lblTimer.isHidden = false
            self.symbolOverlay.isHidden = false
            self.imgStopWatch.isHidden = false
            self.imgScoreboard.isHidden = false
            
            // --- TIMER SETUP ---
            //important step - create box on AR
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerEvents), userInfo: nil, repeats: true)
            isStarted = true
            // Begin Loop to Update CoreML
            loopCoreMLUpdate()
        }
        else
        {
            //set prameters
            mFirstStart = true
            isStarted = false
            self.scrollInfo.isHidden = false
            objectToEnd = 10
            //add score to table
            let server = ServerAction()
            server.UploadDataServer(testNumberIn: 4, sumOfPiontsIn: hitCounter, info: self.lblCounter)
            //navigate to main screen
            performSegue(withIdentifier: "mainMenuSegue", sender: self)
            
        }
    }
    
    
    
    // MARK: - HIDE STATUS BAR
    override var prefersStatusBarHidden : Bool { return true }
}


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */



