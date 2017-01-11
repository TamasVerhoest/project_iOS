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
    
    func addGame(playerOne: String, playerTwo: String, numberOfChallenges: Int){
        
        
        
        let game = Game(value: ["playerOne": playerOne, "playerTwo" : playerTwo, "gameEnum" : "Ongoing"])
        
        
        let challenge = Challenge(value: ["name" : "c1","challengeDescription" : "d1", "sportTypeEnum" : "Basketball", "resultEnum" : "playerOne"])
        let challenge2 = Challenge(value: ["name" : "c2","challengeDescription" : "d2", "sportTypeEnum" : "Soccer", "resultEnum" : "playerTwo"])
        let challenge3 = Challenge(value: ["name" : "c3","challengeDescription" : "d3", "sportTypeEnum" : "Basketball", "resultEnum" : "playerOne"])
        
        game.challenges.append(challenge)
        game.challenges.append(challenge2)
        game.challenges.append(challenge3)
        
        //getting random challenges and linking them to the game
        
        
        try! realm.write {
            self.realm.add(game)
        }
    }
    
    func getAllChallenges() -> Results<Challenge> {
        
        let allChallenges = realm.objects(Challenge)
        
        return allChallenges
    }
    
    func getChallengesFromGames(){
        
    }
    
    func getAllGames() -> Results<Game> {
        let allGames = realm.objects(Game)
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
    
    func getScore(game: Game) -> (Int,Int) {
        let scoreOne = game.challenges.filter("result == 'PlayerOne'").count
        
        let scoreTwo = game.challenges.filter("result == 'PlayerTwo'").count
        
        return (scoreOne,scoreTwo)
    }
    
    func getToDoChallenge(game: Game) -> Challenge {
        
        let challenge = game.challenges.filter("result == 'NotDecided'").first!
        
        return challenge
    }
    
    func playerOneWins(game: Game) {
        
        let challenge = getToDoChallenge(game: game)
        
       //challenge.resultEnum = .PlayerOne
        
        try! realm.write {
           challenge.resultEnum = .PlayerOne
            
           
        }
         checkIfGameEnded(game: game)
      
    }
    
    func playerTwoWins(game: Game) {
        
        let challenge = getToDoChallenge(game: game)
        
        //challenge.resultEnum = .PlayerOne
        
        try! realm.write {
            challenge.resultEnum = .PlayerTwo
            
           
        }
         checkIfGameEnded(game: game)
        
    }
    
    func checkIfGameEnded(game: Game) {
        
        let scores = getScore(game: game)
        var result: GameResult = .Ongoing
        
        if game.challenges.count == game.challenges.filter("result != 'NotDecided'").count {
            if scores.0 > scores.1 {
                result = .WonByPlayerOne
            } else {
                result = .WonByPlayerTwo
            }
            
            try! realm.write {
                game.gameEnum = result
            }
            
        }
    }
    
    
    
    func deleteRealm(){
        try! realm.write {
            realm.deleteAll()
           
        }
    }
    
    //get number of challenges won by player one // two
    
    
    
    
    
    
    
}
