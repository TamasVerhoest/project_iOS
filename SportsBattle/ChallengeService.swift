import Foundation
import RealmSwift

class ChallengeService {
    
    var allChallenges = [Challenge]()
    
    init() {
        
        allChallenges.append(Challenge(value: ["name" : "Zweepslag","challengeDescription" : "De speler moet met een slagbeweging van een handdoek, vastgemaakt aan de vloer, een pingpongbal in een wasmand krijgen."]))
        
         allChallenges.append(Challenge(value: ["name" : "Over De Kop","challengeDescription" : "De speler moet een halfvolle fles water rechtop, op een tafel gooien."]))
        
        allChallenges.append(Challenge(value: ["name" : "Lepeltje Lepeltje","challengeDescription" : "Sla op een lepel zodanig dat een tweede lepel in een glas wordt gekatapulteerd."]))
        
        allChallenges.append(Challenge(value: ["name" : "Snoepreisje","challengeDescription" : "De speler moet met een rietje in de mond een snoepje transporteren van een schaal naar 4 andere rietjes die rechtop zijn vastgemaakt aan een tafel."]))
        
         allChallenges.append(Challenge(value: ["name" : "Door het oog van de naald","challengeDescription" : "Gebruik 1 hand om een draad door het oog van 10 naalden te rijgen."]))
        
         allChallenges.append(Challenge(value: ["name" : "In schoenvlucht","challengeDescription" : "Gebruik je voet om een schoen op tafel te gooien."]))
        
         allChallenges.append(Challenge(value: ["name" : "Stapelgek","challengeDescription" : "De speler moet een stapel maken van 36 plastic bekers in de vorm van een driehoek. Als dit volbracht is, moeten de bekers terug naar 1 enkele stapel gebracht worden."]))
        
        allChallenges.append(Challenge(value: ["name" : "Wet van Newton","challengeDescription" : "Houd 3 ballonnen 1 minuut lang in de lucht."]))
        
         allChallenges.append(Challenge(value: ["name" : "Driesprong","challengeDescription" : "De speler moet 3 pingpongballen in een kom gooien door ze eerst op 3 borden te laten stuiteren."]))
        
        allChallenges.append(Challenge(value: ["name" : "Loopneus","challengeDescription" : "De speler moet 5 watten bolletjes van de ene schaal naar de andere verplaatsen met de neus die is ingesmeerd met vaseline."]))
        
         allChallenges.append(Challenge(value: ["name" : "Blikvanger","challengeDescription" : "De speler moet door middel van lege blikjes en papieren borden een omgekeerde piramide bouwen."]))
        
        allChallenges.append(Challenge(value: ["name" : "Moer toren","challengeDescription" : "De speler moet een toren bouwen door 10 grote moeren van een Chinees stokje te laten glijden."]))
        
         allChallenges.append(Challenge(value: ["name" : "Waterballon","challengeDescription" : "De speler moet een ballon in een vuilnisbak manoeuvreren door gebruik te maken van een plantenspuit."]))
        
        allChallenges.append(Challenge(value: ["name" : "De langste adem","challengeDescription" : "De speler moet een ballon opblazen en laten leeglopen om zo 15 plastic bekers van een tafel te blazen."]))
        
         allChallenges.append(Challenge(value: ["name" : "Papieren wolkenkrabber","challengeDescription" : "De deelnemer moet een toren bouwen van steekkaarten, waarvan elke laag bestaat uit 2 op voorhand gevouwen kaarten waar een platte kaart op rust."]))

        allChallenges.append(Challenge(value: ["name" : "Jenga Domino","challengeDescription" : "De speler moet een domino pad creëren met blokken van het reuze jengaspel die op de korte zijde rechtop staan. De speler duwt de pakken zo omver dat het laatste pak de bel doet rinkelen."]))
        
        allChallenges.append(Challenge(value: ["name" : "Olifantenmars","challengeDescription" : "Gooi flessen om met een tennisbal hangende in een panty die over het hoofd getrokken wordt."]))
        
        allChallenges.append(Challenge(value: ["name" : "Pasta mania","challengeDescription" : "Gebruik je mond om 6 pasta penne, aan 1 ongekookte spaghetti te rijgen."]))
        
        allChallenges.append(Challenge(value: ["name" : "Communicerende vaten","challengeDescription" : "3 lege blikjes en 3 volle moeten van de ene hand in de andere terechtkomen zonder ze neer te zetten."]))
        
        allChallenges.append(Challenge(value: ["name" : "Blikken en Blozen","challengeDescription" : "De speler moet proberen om door middel van het schieten van elastiekjes een driehoekige toren van blikjes volledig om te gooien."]))
        
        allChallenges.append(Challenge(value: ["name" : "Ken je pen","challengeDescription" : "De speler moet een potlood in een glas stuiteren."]))
        
        allChallenges.append(Challenge(value: ["name" : "Bellen blazen","challengeDescription" : "De speler moet een zeepbel blazen en door een hoepel leiden."]))
        
        allChallenges.append(Challenge(value: ["name" : "Blaaskaak","challengeDescription" : "De speler moet 52 speelkaarten wegblazen terwijl de joker bovenop de glazen fles blijft liggen."]))
        
        allChallenges.append(Challenge(value: ["name" : "Zaklopen","challengeDescription" : "Verplaats 5 papieren zakken, van verschillende hoogtes, met alleen de mond."]))
        
        allChallenges.append(Challenge(value: ["name" : "Kleur bekennen","challengeDescription" : "Sorteer 18 gekleurde snoepjes per kleur."]))
        
        allChallenges.append(Challenge(value: ["name" : "Appelboom","challengeDescription" : "Stapel 5 rode appels bovenop elkaar."]))
        
        allChallenges.append(Challenge(value: ["name" : "De rode draad","challengeDescription" : "De speler start met een stapel rode bekers en 1 blauwe beker onderaan. De speler moet de bekers één voor één van boven naar beneden brengen zodat de blauwe beker uiteindelijk weer onderaan belandt."]))
        
    }
    
    func getRandomChallenges(amount: Int) -> [Challenge]{
        
        
        return allChallenges.choose(amount)
    
    }
    
    
}

extension Array {
    /// Returns an array containing this sequence shuffled
    var shuffled: Array {
        var elements = self
        return elements.shuffle()
    }
    /// Shuffles this sequence in place
    @discardableResult
    mutating func shuffle() -> Array {
        indices.dropLast().forEach {
            guard case let index = Int(arc4random_uniform(UInt32(count - $0))) + $0, index != $0 else { return }
            swap(&self[$0], &self[index])
        }
        return self
    }
    var chooseOne: Element { return self[Int(arc4random_uniform(UInt32(count)))] }
    func choose(_ n: Int) -> Array { return Array(shuffled.prefix(n)) }
}
