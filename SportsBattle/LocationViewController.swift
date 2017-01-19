import UIKit
import CoreLocation
import MapKit
import Foundation

class LocationViewController: UIViewController,CLLocationManagerDelegate {
    
    var sportLocations: [SportLocation] = []
    var selectedLocation = SportLocation()
    let reach = Reachability()
    let manager = CLLocationManager()
    var myLocation = CLLocationCoordinate2D()
  
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var disconnectedImage: UIImageView!
    
    
    @IBAction func navigate(){
        if self.selectedLocation.name != "" {
            openMapForPlace(sportlocation: self.selectedLocation)
        }
       
    }
    
    @IBAction func selectClosest() {
        
        var closestDistance: Double = 99999999999999.9999999999
        var closestLocation = SportLocation()
        var indexOfLocation = 0
        
        for (index,location) in sportLocations.enumerated() {
            
            let distanceLocations = self.calculateDistance(selectedCoordinate: location.location)
            
            if distanceLocations < closestDistance {
                closestLocation = location
                closestDistance = distanceLocations
                indexOfLocation = index
            }
        }

        let indexPath = IndexPath(item: indexOfLocation, section: 0)
        
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.middle)
        
        self.selectedLocation = closestLocation
        
        // Trigger to add pin
        mapView.removeAnnotations(mapView.annotations)
        mapView.showsUserLocation = true
        mapView.region = MKCoordinateRegion(center: closestLocation.location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        let pin = MKPointAnnotation()
        pin.coordinate = closestLocation.location
        mapView.addAnnotation(pin)
        
    }
    
   
    
    
    override func viewDidLoad() {
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
        //check if connected to any network
        if !reach.connectedToNetwork() {
                tableView.isHidden = true
                mapView.isHidden = true
                disconnectedImage.isHidden = false
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        self.myLocation = location.coordinate
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
    
    func calculateDistance(selectedCoordinate: CLLocationCoordinate2D) -> Double {
        
        let current = CLLocation(latitude: self.myLocation.latitude, longitude: self.myLocation.longitude)
        let selected = CLLocation(latitude: selectedCoordinate.latitude, longitude: selectedCoordinate.longitude)
        
        let distanceInMeter = current.distance(from: selected)
        return distanceInMeter
    }
}


extension LocationViewController: UITableViewDelegate{
    
}
