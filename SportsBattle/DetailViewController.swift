import RealmSwift
import Foundation
import UIKit


class DetailViewController : UIViewController {
    
    var game = Game()
    let service = RealmService()
    var timer = Timer()
    
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    var seconds = 60
    
    
    @IBAction func playerOneWon() {
        
        service.playerOneWins(game: self.game)
        
        performSegue(withIdentifier: "backToGames", sender: self)
        
    }
    
    @IBAction func playerTwoWon(){
        
        service.playerTwoWins(game: self.game)
        
        performSegue(withIdentifier: "backToGames", sender: self)
    }
    
    @IBAction func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(DetailViewController.counter), userInfo: nil, repeats: true)
        startButton.isEnabled = false
    }
    
    @IBAction func stopTimer(){
        timer.invalidate()
        seconds = 60
        timerLabel.text = "\(seconds) seconds"
        startButton.isEnabled = true
    }
    
    func counter() {
        seconds -= 1
        timerLabel.text = "\(seconds) seconds"
        
        if (seconds == 0) {
            timer.invalidate()
            seconds = 60
            startButton.isEnabled = true
        }
    }
    
    override func viewDidLoad() {
        let challenge = service.getToDoChallenge(game: game)
        name.text = challenge.name
        desc.text = challenge.challengeDescription

        
    }
    
}
