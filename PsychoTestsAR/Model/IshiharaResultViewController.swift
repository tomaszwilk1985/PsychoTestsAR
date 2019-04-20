
import UIKit

class IshiharaResultViewController: UIViewController {
    //pobieranie danych
    let userDataTests = UserDefaults.standard
    
    //polacznie do serwera
    let ServerRq = ServerAction()
    var checkUpload: Int = 0
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var saveResult: UIButton!
    @IBOutlet weak var serverInfoLabel: UILabel!
    
    
    @IBAction func backMainController(_ sender: UIButton) {
        performSegue(withIdentifier: "MainMenu", sender: self)
    }
    
    //zapisanie wyniku od bazy danych
    // przekazywanie punktow score i numeru testu nrTest
    @IBAction func saveResultButton(_ sender: UIButton) {
        if checkUpload == 0 {
            
            let score = userDataTests.integer(forKey: "scoreResult")
            let nrTest = userDataTests.integer(forKey: "nrTest")
            ServerRq.UploadDataServer(testNumberIn: nrTest, sumOfPiontsIn: score, info: serverInfoLabel)
            checkUpload = 1
            
            //pop up potwierdzajacy
            let alert = UIAlertController(title: "Test został zapisany", message: "Jeśli chcesz zobaczyć wyniki wszystkich Twoich testów, przejedź do zakładki MOJE TESTY", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Strona główna", style: .default) { (UIAlertAction) in
                self.performSegue(withIdentifier: "MainMenu", sender: self)
            }
            
            alert.addAction(restartAction)
            present(alert, animated: true, completion:  nil)
            
        }
        
        if checkUpload == 1 {
            saveResult.isEnabled = false
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let score = userDataTests.integer(forKey: "scoreResult")
        
        resultLabel.text = "\(score)/10 pktów"
        
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
