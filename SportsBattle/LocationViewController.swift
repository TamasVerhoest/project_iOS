import UIKit
import CoreLocation
import Foundation

class LocationViewController: UITableViewController {
    
    fileprivate var sportLocations: [SportLocation] = []
    
    private var currentTask: URLSessionTask?
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
       
        //let location = sportLocations[indexPath.row]
        //cell.textLabel!.text = location.name
        //cell.detailTextLabel!.text = location.wijk
        return cell
        
    }
   
    override func viewDidLoad() {
      
        getHttpData(urlAddress: "https://datatank.stad.gent/4/cultuursportvrijetijd/buurtsportlocaties.json")
    }
    
    func getHttpData(urlAddress : String)
    {
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
                        let lat = coordinates[0]
                        let long = coordinates[1]
                        
                        let coo = CLLocationCoordinate2D(latitude: lat, longitude: long)
                        
                        location = SportLocation(name: name, location: coo, wijk: wijk)
                        
                        self.sportLocations.append(location)
                        
                    }
                    
                     
                    
                    print(self.sportLocations.count)
                    
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
