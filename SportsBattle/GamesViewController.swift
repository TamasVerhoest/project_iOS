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
            return "Ongoing Games"
        } else {
            return "Finished Games"
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath)
        
        if indexPath.section == 0 {
            let game = service.getOngoingGame(index: indexPath.item)
            let score = service.getScore(game: game)
           
            cell.textLabel?.text = "\(game.playerOne) <> \(game.playerTwo)"
            cell.detailTextLabel?.text = "\(score.0) - \(score.1)"
        } else {
            
            // check who won and adjust img
            
            let game = service.getPlayedGame(index: indexPath.item)
            cell.textLabel?.text = "\(game.playerOne) <> \(game.playerTwo)"
            cell.detailTextLabel?.text = game.gameEnum.rawValue
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

