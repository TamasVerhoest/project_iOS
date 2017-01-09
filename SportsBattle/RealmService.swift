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
        
        
        
        let game = Game(value: ["playerOne": playerOne, "playerTwo" : playerTwo, "result" : "WonByPlayerOne"])
        
        
        let challenge = Challenge(value: ["name" : "c1","challengeDescription" : "d1", "sportTypeEnum" : "Basketball"])
        let challenge2 = Challenge(value: ["name" : "c2","challengeDescription" : "d2", "sportTypeEnum" : "Soccer"])
        
        game.challenges.append(challenge)
        game.challenges.append(challenge2)
        
 
        
        
        //getting random challenges and linking them to the game
        
        
        try! realm.write {
            self.realm.add(game)
        }
    }
    
    func getAllChallenges() -> Results<Challenge> {
        
        let allChallenges = realm.objects(Challenge)
        print(allChallenges)
        return allChallenges
    }
    
    func getChallengesFromGames(){
        
    }
    
    func getAllGames() -> Results<Game> {
        let allGames = realm.objects(Game)
        print(allGames)
        return allGames
    }
    
    func getPlayedGame(index: Int) -> Game {
        let played = getPlayedGames()
        
        return played[index]
    }
    
    func getOngoingGame(index: Int) -> Game {
        let ongoing = getOngoingGames()
        
        return ongoing[index]
    }
    
    func getPlayedGames() -> Results<Game>{
       let allGames = getAllGames()
        
        return allGames.filter("result != 'Ongoing'")
    }
    
    func getOngoingGames() -> Results<Game>{
        let allGames = getAllGames()
        
        return allGames.filter("result == 'Ongoing'")
    }
    
    
    
    func deleteRealm(){
        try! realm.write {
            realm.deleteAll()
           
        }
    }
    
    //get number of challenges won by player one // two
    
    
    
    
    
    
    
}
