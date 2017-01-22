import UIKit

class InfoViewController: UIViewController {
    
    var challenge = Challenge()
    
    @IBOutlet weak var benodigdheden: UILabel!
    @IBOutlet weak var instructies: UITextView!
    
    
    @IBAction func returnToDetails(){
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        
        benodigdheden.text = challenge.requirements
        instructies.text = challenge.instructions
    }
    
    func formatRequirements(req: [String]) {
        
    }
}
