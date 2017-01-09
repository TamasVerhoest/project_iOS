import Foundation
import RealmSwift

class Game: Object {
    dynamic var playerOne = ""
    dynamic var playerTwo = ""
    dynamic var currentChallenge = 0
    dynamic var numberOfChallenges = 0
    dynamic var result = GameResult.Ongoing.rawValue
    
    let challenges = List<Challenge>()
    
    var gameEnum: GameResult {
        get {
            return GameResult(rawValue: result)!
        }
        set {
            result = newValue.rawValue
        }
    }
    
    
}

enum GameResult: String {
    case Ongoing
    case WonByPlayerOne
    case WonByPlayerTwo
}
