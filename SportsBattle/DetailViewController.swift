import RealmSwift
import Foundation
import UIKit

class DetailViewController : UIViewController {
    
    var game = Game()
    let service = RealmService()
    
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var desc: UILabel!
    
    @IBAction func playerOneWon() {
        
        service.playerOneWins(game: self.game)
        
        performSegue(withIdentifier: "backToGames", sender: self)
        
    }
    
    @IBAction func playerTwoWon(){
        
        service.playerTwoWins(game: self.game)
        
        performSegue(withIdentifier: "backToGames", sender: self)
    }
    
    override func viewDidLoad() {
        let challenge = service.getToDoChallenge(game: game)
        name.text = challenge.name
        desc.text = challenge.challengeDescription
        
        print("loaded")
        
    }
    
}
