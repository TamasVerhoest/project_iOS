import UIKit
import RealmSwift


class CreateViewController : UIViewController {
    
    let service = RealmService()
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepperValue: UILabel!
    
    
    @IBAction func stepperAction(_ sender: AnyObject) {
        stepperValue.text = String(stepper.value)
    }
    
    
    override func viewDidLoad() {
     
        
    }
}
