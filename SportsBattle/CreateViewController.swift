import UIKit
import RealmSwift


class CreateViewController : UIViewController {
    
    let service = RealmService()
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepperValue: UILabel!
    @IBOutlet weak var playerOne: UITextField!
    @IBOutlet weak var playerTwo: UITextField!
    
    
    @IBAction func stepperAction(_ sender: AnyObject) {
        stepperValue.text = String(stepper.value)
    }
    
    @IBAction func createGame(){
        service.addGame(playerOne: playerOne.text!, playerTwo: playerTwo.text!, numberOfChallenges: Int(stepper.value))
    }
    
    
    override func viewDidLoad() {
        service.deleteRealm()
        
        //Code to get rid of keyboard after input
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
