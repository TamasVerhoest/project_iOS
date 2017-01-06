import UIKit
import CoreLocation
import Foundation

class LocationViewController: UITableViewController {
    
    var sportLocations: [SportLocation] = []
    
    private var currentTask: URLSessionTask?
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sportLocations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
       
        let location = sportLocations[indexPath.row]
        cell.textLabel!.text = location.name
        cell.detailTextLabel!.text = location.wijk
        return cell
        
    }
   
    override func viewDidLoad() {
      
        
    }
    
}
