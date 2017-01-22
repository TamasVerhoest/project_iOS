import RealmSwift
import Foundation
import UIKit


class DetailViewController : UIViewController {
    
    var game = Game()
    var service = RealmService()
    var timer = Timer()
    var challenge = Challenge()
    
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var playerOne: UILabel!
    @IBOutlet weak var playerTwo: UILabel!
    
    
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
        timerLabel.text = "\(seconds) seconden"
        startButton.isEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showInfo" {
            
            let destination = (segue.destination as! InfoViewController)
            
            destination.challenge = self.challenge
            
        }
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
        
        self.challenge = service.getToDoChallenge(game: game)
        let scores = service.getScore(game: game)
        
        scoreLabel.text = "\(scores.0) - \(scores.1)"
        name.text = challenge.name
        desc.text = challenge.challengeDescription
        playerOne.text = game.playerOne
        playerTwo.text = game.playerTwo

        
    }
    
}
