import UIKit

class OverviewViewController : UITableViewController {
    
    
    
    @IBAction func showLocations(){
        performSegue(withIdentifier: "showLocations", sender: self)
    }
    
    @IBAction func createGame(){
        performSegue(withIdentifier: "createGame", sender: self)
    }
    
    @IBAction func showGames(){
        performSegue(withIdentifier: "showGames", sender: self)
    }
    
    
}
