//
//  ScoreBoardController.swift
//  PsychoTestsAR
//
//  Created by AT Wolfar on 03/04/2019.
//  Copyright © 2019 PUMTeam. All rights reserved.
//

import UIKit

class ScoreBoardController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    // usertests
    
    let ServerReq = ServerAction ()
    let user_data_tests = UserDefaults.standard
    
    


    @IBOutlet weak var testListUser: UITableView!
    @IBOutlet weak var lbl_apple_id: UILabel!
    
    
    @IBOutlet weak var btn_start: UIButton!
    
    @IBAction func btn_go_start(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let testlist = user_data_tests.array(forKey: "usertests") as? [String] ?? [String]()
        return testlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = testListUser.dequeueReusableCell(withIdentifier: "user_test_result", for: indexPath)
        let testlist = user_data_tests.array(forKey: "usertests") as? [String] ?? [String]()
        cell.textLabel?.text = testlist[indexPath.row]
        cell.textLabel?.font = UIFont(name: "System", size: 7.0)
        // cell.separatorInset = UIEdgeInsets.zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let testlist = user_data_tests.array(forKey: "usertests") as? [String] ?? [String]()
            let currentRow = testlist[indexPath.row]
            let arrCurrentRow: [String] = currentRow.components(separatedBy: " ")
            let outputDate: String = arrCurrentRow[1] + " " + arrCurrentRow[2]
            
            let alert = UIAlertController(title: "Usuwanie testu", message: "Czy chcesz usunąć test?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Usuń", style: .destructive){
                _ in
                deleteTest()
                
            })
            alert.addAction(UIAlertAction(title: "Nie usuwaj", style: .default){
                _ in
                return
            })
            
            func deleteTest () {
                ServerReq.DeleteTest(id_data_test: outputDate)
                let server_info: String = user_data_tests.string(forKey: "testdelete") ?? String()
                if server_info == "DELETE OK" {
                    var testlist = user_data_tests.array(forKey: "usertests") as? [String] ?? [String]()
                    testlist.remove(at: indexPath.row)
                    user_data_tests.set(testlist, forKey: "usertests")
                    testListUser.reloadData()
                }
            }
            present(alert, animated: true, completion: nil)
            
        }
    }
    
    
    
    // @IBOutlet weak var testListsUser: UITableView!
    // user_tests_list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ServerReq.ShowMyTests()
        lbl_apple_id.text = "Apple ID \(ServerReq.AppleID)"
        btn_start.layer.cornerRadius = 10
        
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
