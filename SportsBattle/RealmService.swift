import RealmSwift
import Foundation

class RealmService {
    
    let realm = try! Realm()
    let randomChallenges = List<Challenge>()
    let challengeService = ChallengeService()
    
    
    func addGame(playerOne: String, playerTwo: String, numberOfChallenges: Int){
        
        
        let challenges = challengeService.getRandomChallenges(amount: numberOfChallenges)
        
        let game = Game(value: ["playerOne": playerOne, "playerTwo" : playerTwo, "gameEnum" : "Ongoing"])
        
        
        for challenge in challenges {
            game.challenges.append(challenge)
        }
        
        
        try! realm.write {
            self.realm.add(game)
        }
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
    
    func getChallenge(game: Game) -> (Int,Int) {
        
        return getScore(game: game)
        
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
