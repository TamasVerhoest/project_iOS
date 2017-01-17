import Foundation
import RealmSwift

class ChallengeService {
    
    let allChallenges = List<Challenge>()
    
    init() {
        allChallenges.append(Challenge(value: ["name" : "","challengeDescription" : "",]))

        
    }
    
    func getRandomChallenges(amount: Int) {
        
    }
}
