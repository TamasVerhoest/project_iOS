import CoreLocation

class SportLocation {
    
    let name: String
    let location: CLLocationCoordinate2D
    let wijk: String
    
    
    init(name: String, location: CLLocationCoordinate2D, wijk: String) {
        self.name = name
        self.location = location
        self.wijk = wijk
    }
    
    init(){
        self.name = ""
        self.location = CLLocationCoordinate2D()
        self.wijk = ""
    }
}

extension SportLocation: CustomStringConvertible {
    
    var description: String {
        return name
    }
}

