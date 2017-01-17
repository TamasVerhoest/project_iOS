import Foundation
import RealmSwift

class Challenge: Object {
    dynamic var name = ""
    dynamic var challengeDescription = ""
    dynamic var result = Result.NotDecided.rawValue
    
    
    var resultEnum: Result {
        get {
            return Result(rawValue: result)!
        }
        set {
            result = newValue.rawValue
        }
    }
}


enum Result: String {
    case NotDecided
    case PlayerOne
    case PlayerTwo
}
