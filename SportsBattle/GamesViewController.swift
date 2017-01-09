import RealmSwift
import UIKit

class GamesViewController: UITableViewController {
    
    
    let service = RealmService()
 
    
    override func viewDidLoad() {
        
      service.getAllGames()
      
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
            cell.textLabel?.text = "\(game.playerOne) versus \(game.playerTwo)"
        } else {
            let game = service.getPlayedGame(index: indexPath.item)
            cell.textLabel?.text = "\(game.playerOne) versus \(game.playerTwo)"
        }
        
        return cell
    }
    
    
    
    
    
    
}

