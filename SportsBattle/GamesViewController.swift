import RealmSwift
import UIKit

class GamesViewController: UIViewController {
    
    let service = RealmService()
    
    
    override func viewDidLoad() {
        
        let basket = service.getBasketChallenges()
        
        print(basket)
    }
}
