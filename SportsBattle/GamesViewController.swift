import RealmSwift
import UIKit

class GamesViewController: UITableViewController {
    
    
    var service = RealmService()
    var selectedGame = Game()
    
    override func viewDidLoad() {

    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       if segue.identifier == "showDetails" {
            
            let destination = (segue.destination as! DetailViewController)
            
            destination.game = self.selectedGame
        
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Lopende battle's"
        } else {
            return "Afgewerkte battle's"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
       
            return service.getOngoingGames().count
    
        } else {
            return service.getPlayedGames().count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! CustomGameCell
       
        if indexPath.section == 0 {
            let game = service.getOngoingGame(index: indexPath.item)
            let score = service.getScore(game: game)
            cell.nameLabel?.text = "\(game.playerOne) <> \(game.playerTwo)"
            cell.scoreLabel?.text = "\(score.0) - \(score.1)"
        } else {
            
            // check who won and adjust img
            let game = service.getPlayedGame(index: indexPath.item)
            let score = service.getScore(game: game)
            cell.nameLabel?.text = "\(game.playerOne) <> \(game.playerTwo)"
            cell.scoreLabel?.text = "\(score.0) - \(score.1)"
            
            if score.0 > score.1 {
                cell.statusImage.image = #imageLiteral(resourceName: "diamond")
            } else {
                cell.statusImage.image = #imageLiteral(resourceName: "spades")
            }
        }
        
        return cell
        
  
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            selectedGame = service.getOngoingGame(index: indexPath.item)
            service.checkIfGameEnded(game: selectedGame)
            performSegue(withIdentifier: "showDetails", sender: self)
            
            
        }
        
    }
    
    
    
    
}

