import UIKit
import CoreLocation
import MapKit
import Foundation

class LocationViewController: UIViewController {
    
    var sportLocations: [SportLocation] = []
    var selectedLocation = SportLocation()
    let reach = Reachability()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var disconnectedImage: UIImageView!
    
    
    @IBAction func navigate(){
        if self.selectedLocation.name != "" {
            openMapForPlace(sportlocation: self.selectedLocation)
        }
       
    }
    
    override func viewDidLoad() {
        
        if !reach.connectedToNetwork() {
                tableView.isHidden = true
                mapView.isHidden = true
                disconnectedImage.isHidden = false
        }
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
        self.selectedLocation = sportLocation
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.showsUserLocation = true
        mapView.region = MKCoordinateRegion(center: sportLocation.location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        let pin = MKPointAnnotation()
        pin.coordinate = sportLocation.location
        mapView.addAnnotation(pin)
        
        
    }
    
    func openMapForPlace(sportlocation: SportLocation) {
        
    
        
        let latitude:CLLocationDegrees =  sportlocation.location.latitude
        let longitude:CLLocationDegrees =  sportlocation.location.longitude
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "\(sportlocation.name)"
        mapItem.openInMaps(launchOptions: options)
        
    }
}
extension LocationViewController: UITableViewDelegate{
    
}
