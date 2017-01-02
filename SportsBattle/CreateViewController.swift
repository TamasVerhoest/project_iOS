import UIKit

class CreateViewController : UIViewController {
    

    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepperValue: UILabel!
    
    
    @IBAction func stepperAction(_ sender: AnyObject) {
        stepperValue.text = String(stepper.value)
    }
    
}
