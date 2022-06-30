
import UIKit

public var absoluteWidth: CGFloat {
    var width: CGFloat = 0
    if (UIScreen.main.bounds.height > UIScreen.main.bounds.width) {
        width = UIScreen.main.bounds.width
    } else {
        width = UIScreen.main.bounds.height
    }
    return width
}

class MainTabBarController: UITabBarController {

    let firstVC = CollectionViewController()
    let secondVC = FavouritesViewController()

    override func viewDidLoad() {
        setupControllers()
        super.viewDidLoad()
        //красим все бары в один цвет
        UINavigationBar.appearance().backgroundColor = .systemGray6
        UITabBar.appearance().backgroundColor = .systemGray6
    }
    
    func setupControllers() {
        firstVC.tabBarItem.title = "Collection"
        firstVC.tabBarItem.image = UIImage(systemName: "rectangle.grid.2x2")
        firstVC.navigationItem.title = "Unsplash Photo Collection"
        secondVC.tabBarItem.title = "Favorites"
        secondVC.tabBarItem.image = UIImage(systemName: "heart")
        secondVC.navigationItem.title = "Favourites"
        let firstNavigationVC = UINavigationController(rootViewController: firstVC)
        let secondNavigationVC = UINavigationController(rootViewController: secondVC)
        viewControllers = [firstNavigationVC, secondNavigationVC]
    }
}
