import RealmSwift
import Foundation

class RealmService {
    
    let realm = try! Realm()
    let randomChallenges = List<Challenge>()
    
    
    func addChallenge(name: String, desc: String, sport: SportType, status: Result){
        
        
       // let challenge = Challenge(value: ["name" : name,"challengeDescription" : desc, "sportTypeEnum" : sport])
        
        let challenge = Challenge()
        challenge.name = name
        challenge.challengeDescription = desc
        challenge.sportTypeEnum = sport
        
        try! realm.write {
            self.realm.add(challenge)
        }
        
    }
    
    func addGame(playerOne: String, playerTwo: String){
        
        let game = Game(value: ["playerOne": playerOne, "playerTwo" : playerTwo])
        
        //getting random challenges and linking them to the game
        
        
        try! realm.write {
            self.realm.add(game)
        }
    }
    
    func getAllChallenges() -> Results<Challenge> {
        
        let allChallenges = realm.objects(Challenge)
        
        return allChallenges
    }
    
    func getAllGames() -> Results<Game> {
        let allGames = realm.objects(Game)
        return allGames
    }
    
    func getPlayedGames(){
       
    }
    
    func getOngoingGames(){
        
    }
    
    func getBasketChallenges() -> Results<Challenge>{
        let all = getAllChallenges()
        
        let basket = all.filter("sportType == 'Basketball'")
        
        return basket
    }
    
    //get number of challenges won by player one // two
    
    
    
    
    
    
    
}
