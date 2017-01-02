import Foundation

class Game {
    
    var playerOne: String
    var playerTwo: String
    var currentChallenge: Int
    var nrOfWinsPlayerOne: Int
    var nrOfWinsPlayerTwo: Int
    
    var challenges = [Challenge]()
    
    init(playerOne: String, playerTwo: String, nrOfGames: Int) {
        self.playerOne = playerOne
        self.playerTwo = playerTwo
        
        nrOfWinsPlayerOne = 0
        nrOfWinsPlayerTwo = 0
        currentChallenge = 0
        
    }
    
    
    
    
    func checkIfWinner() -> Bool {
        
        
        
        return true
    }
    
    func completeChallenge(){
        
    }
    
}
