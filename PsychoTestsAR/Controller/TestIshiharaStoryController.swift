//
//  TestIshiharaStoryController.swift
//  PsychoTestsAR
//
//  Created by AT Wolfar on 03/04/2019.
//  Copyright © 2019 PUMTeam. All rights reserved.
//

import UIKit

class TestIshiharaStoryController: UIViewController {
    
    @IBAction func btnStartIshara(_ sender: UIButton) {
        
        if CheckInternet.Connection() {
            performSegue(withIdentifier: "ishiharaTest", sender: self)
        } else {
            let alert = UIAlertController(title: "BRAK POŁĄCZENIA Z INTERNETEM!", message: "Aby rozpocząć test musisz mieć dostęp do Internetu", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default){
                _ in
                return
            })
            present(alert, animated: true, completion: nil)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
