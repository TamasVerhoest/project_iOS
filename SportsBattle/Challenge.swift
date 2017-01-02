struct Challenge {
    
    var name: String
    var description: String
    var sportType: SportType
    var gameType: GameType
    
    init(name: String, desc: String, sportType: SportType){
        self.name = name
        self.description = desc
        self.sportType = sportType
        self.gameType = .Ongoing
    }
    
    
    
}

enum SportType {
    case Basketball,
        Soccer,
        Swimming,
        Tabletennis
}

enum GameType {
    case Ongoing, wonByNrOne, wonByNrTwo
}
