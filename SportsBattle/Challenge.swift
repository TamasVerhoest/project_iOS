import Foundation
import RealmSwift

class Challenge: Object {
    dynamic var name = ""
    dynamic var challengeDescription = ""
    dynamic var sportType = SportType.Default.rawValue
    dynamic var result = Result.NotDecided.rawValue
    
    
    var sportTypeEnum: SportType {
        get {
            return SportType(rawValue: sportType)!
        }
        set {
            sportType = newValue.rawValue
        }
    }
    
    var resultEnum: Result {
        get {
            return Result(rawValue: result)!
        }
        set {
            result = newValue.rawValue
        }
    }
}


enum SportType: String {
    case Default
    case Basketball
    case Soccer
    case Swimming
    case Tabletennis
}

enum Result: String {
    case NotDecided
    case PlayerOne
    case PlayerTwo
}
