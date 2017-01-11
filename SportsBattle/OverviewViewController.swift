import UIKit
import CoreLocation
import RealmSwift

class OverviewViewController : UITableViewController {
    
    let service = RealmService()
    var sportLocations: [SportLocation] = []
    
    override func viewDidLoad() {
       
        getData()
        
    }
    
    @IBAction func showLocations(){
        performSegue(withIdentifier: "showLocations", sender: self)
    }
    
    @IBAction func createGame(){
        performSegue(withIdentifier: "createGame", sender: self)
    }
    
    @IBAction func showGames(){
        performSegue(withIdentifier: "showGames", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showLocations" {
            
            let destination = (segue.destination as! LocationViewController)
            destination.sportLocations = sportLocations
        }
        
    }
    
    
    func getData(){
        let urlAddress = "https://datatank.stad.gent/4/cultuursportvrijetijd/buurtsportlocaties.json"
        // Asynchronous Http call to your api url, using NSURLSession:
        guard let url = URL(string: urlAddress) else
        {
            print("Url conversion issue.")
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            // Check if data was received successfully
            if error == nil && data != nil {
                do {
                    // Convert NSData to Dictionary where keys are of type String, and values are of any type
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:AnyObject]
                    
                    //print(json)
                    //let str = json["totalFeatures"] as! Int
                    let features = json["features"] as! [AnyObject]
                    
                    var location: SportLocation
                    
                    for index in 0...features.count - 1 {
                        let feature = features[index] as! [String:AnyObject]
                        
                        let properties = feature["properties"] as! [String:AnyObject]
                        let geometry = feature["geometry"] as! [String:AnyObject]
                        
                        let coordinates = geometry["coordinates"] as! [Double]
                        let wijk = properties["Wijk"] as! String
                        
                        let name = properties["Naam"] as! String
                        let lat = coordinates[1]
                        let long = coordinates[0]
                        
                        let coo = CLLocationCoordinate2D(latitude: lat, longitude: long)
                        
                        location = SportLocation(name: name, location: coo, wijk: wijk)
                        
                        self.sportLocations.append(location)
                        
                    }
                    
                } catch {
                    print(error)
                    // Something went wrong
                }
            }
            else if error != nil
            {
                print(error)
            }
        }).resume()
        
    }

}

    
