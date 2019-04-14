//
//  ServerCallAndResponse.swift
//  Psychotests
//
//  Created by Robert Nowiński on 28/02/2019.
//  Copyright © 2019 Robert Nowiński. All rights reserved.
//
import Foundation
import UIKit

class ServerAction {
    let AppleID: String = (UIDevice.current.identifierForVendor?.uuidString)!
    internal let urlIQ: String = "http://psychotests.pl/iPhone/?data=testjson"
    internal let urlUPDATE: String = "http://psychotests.pl/iPhone/?data=addtest"
    internal let urlUSERTESTS: String = "http://psychotests.pl/iPhone/?data=showmytests"
    internal let urlDELETECURRENTROW: String = "http://psychotests.pl/iPhone/?data=deletetest"
    
    // Metoda pobiera z adresu URL testy IQ (JSON) i tworzy 3 tablice [Sreing]: 1 - pytania, 2 - odpowiedzi, 3 - wartości odpowiedźi
    func dataIQTests () {
        let url_string = self.urlIQ
        guard let url = URL (string: url_string) else {return}
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            if error != nil {
                print (error!.localizedDescription)
            }
            guard let data = data else {return}
            
            var questions = [String]()
            var answers = [String]()
            var values = [String]()
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String: Any]]
                for exjson in json {
                    if exjson["question"] != nil {questions.append(exjson["question"] as! String)}
                    if exjson["answer"] != nil {answers.append(exjson["answer"] as! String)}
                    if exjson["value"] != nil {values.append(exjson["value"] as! String)}
                    
                    let user_save = UserDefaults.standard
                    user_save.set(questions, forKey: "questions")
                    user_save.set(answers, forKey: "answers")
                    user_save.set(values, forKey: "values")
                }
            } catch let jsonError {
                print (jsonError)
            }
            }.resume()
    }
    
    // M: Upload User Apple ID (device) and tests results
    // -----------------------------------------------------------------------
    func UploadDataServer (testNumberIn: Int, sumOfPiontsIn: Int, info: UILabel) {
        
        struct Order: Codable {
            let customerID: String
            let testNumber: Int
            let sumOfPoints: Int
        }
        let order = Order (customerID: self.AppleID, testNumber: testNumberIn, sumOfPoints: sumOfPiontsIn)
        
        guard let uploadData = try? JSONEncoder().encode(order) else {
            return
        }
        let url = URL (string: self.urlUPDATE)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) {data, response, error in
            
            var checkConnectResponse: String?
            
            if let error = error {
                print ("error: \(error)")
                checkConnectResponse = String ("error: \(error)")
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                    print ("server error")
                    checkConnectResponse = "Server Error"
                    return
            }
            
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data,
                let dataString = String(data: data, encoding: .utf8) {
                checkConnectResponse = dataString
                // print ("go data: \(checkConnectResponse!)")
                
                // JSON SERVER RESPONSE
                struct ServerResp: Codable {
                    var output: String
                }
                let jsonO = dataString.data(using: .utf8)!
                let jsonOutput = try? JSONDecoder().decode(ServerResp.self, from: jsonO)
                // end -----------------------------------
                // Insert resp.
                DispatchQueue.main.async { info.text = String (jsonOutput!.output)}
            }
        }
        task.resume()
    }
    // *** END METHOD -------------------------------------------------------------
    
    
    // Delete row in DB (test)
    func DeleteTest (id_data_test: String) {
        struct Order: Codable {
            let id_user: String
            let id_data_test: String
        }
        
        let order = Order(id_user: self.AppleID, id_data_test: id_data_test)
        
        guard let uploadData = try? JSONEncoder().encode(order) else {
            return
        }
        let url = URL (string: self.urlDELETECURRENTROW)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) {data, response, error in
            
            if let error = error {
                print ("error: \(error)")
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                    print ("server error")
                    return
            }
            
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data,
                let dataString = String(data: data, encoding: .utf8) {
                
                // JSON SERVER RESPONSE
                struct ServerResp: Codable {
                    var output: String
                }
                let jsonO = dataString.data(using: .utf8)!
                let jsonOutput = try? JSONDecoder().decode(ServerResp.self, from: jsonO)
                
                if jsonOutput != nil {
                    let testInfo = String(jsonOutput!.output)
                    let user_save = UserDefaults.standard
                    user_save.set(testInfo, forKey: "testdelete")
                }
            }
        }
        task.resume()
    }
    
    
    
    // POKAŻ TESTY UŻYTKOWNIKA
    // ---------------------------------------------------------------------------
    func ShowMyTests () -> Void {
        
        
        struct Order: Codable {
            let customerID: String
        }
        
        let order = Order (customerID: self.AppleID)
        
        guard let uploadData = try? JSONEncoder().encode(order) else {
            return
        }
        let url = URL (string: self.urlUSERTESTS)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) {data, response, error in
            if let error = error {
                print ("error: \(error)")
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                    print ("server error")
                    return
            }
            
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data,
                let dataString = String(data: data, encoding: .utf8) {
                // print ("go data: \(dataString)")
                
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String: AnyObject]]
                
                var ID_tests = Array<String>()
                
                if json != nil {
                    var iterator:Int = 1
                    for row in json!! {
                        // let i = String(iterator)
                        ID_tests.append("Data: " + (row["datetime"] as! String) + " | Nr Testu: " + (row["id_tests"] as! String) + " | Punkty: " + (row["points"] as! String))
                        iterator += 1
                        
                        //id_tests
                        //points
                    }
                    ID_tests.reverse()
                    let user_save = UserDefaults.standard
                    user_save.set(ID_tests, forKey: "usertests")
                    
                }
            }
        }
        task.resume()
    }
}
