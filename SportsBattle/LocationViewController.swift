import UIKit
import CoreLocation
import MapKit
import Foundation

class LocationViewController: UIViewController {
    
    var sportLocations: [SportLocation] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
   
    override func viewDidLoad() {
        
    }
    
}

extension LocationViewController: UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return sportLocations.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
            let location = sportLocations[indexPath.row]
            cell.textLabel!.text = location.name
            cell.detailTextLabel!.text = location.wijk
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sportLocation = sportLocations[indexPath.row]
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.showsUserLocation = true
        mapView.region = MKCoordinateRegion(center: sportLocation.location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        let pin = MKPointAnnotation()
        pin.coordinate = sportLocation.location
        mapView.addAnnotation(pin)
        
    }
}
extension LocationViewController: UITableViewDelegate{
    
}
