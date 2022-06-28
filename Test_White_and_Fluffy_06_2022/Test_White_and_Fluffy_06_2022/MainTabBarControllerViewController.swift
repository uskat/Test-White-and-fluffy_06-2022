
import UIKit

public var topBarHeight: CGFloat = 0

public var absoluteWidth: CGFloat {
    var width: CGFloat = 0
    if (UIScreen.main.bounds.height > UIScreen.main.bounds.width) {
        width = UIScreen.main.bounds.width
    } else {
        width = UIScreen.main.bounds.height
    }
    return width
}

//код для проверки ориентации экрана и изменения видимости статус бара.
public func checkOrientation() {
    if (UIScreen.main.bounds.height > UIScreen.main.bounds.width) {
        //print("height > width")
        UIApplication.shared.statusBarUIView?.isHidden = false
        UIApplication.shared.statusBarUIView?.backgroundColor = .systemGray6
        //absoluteWidth = UIScreen.main.bounds.width
    } else {
        //print("isHidden")
        UIApplication.shared.statusBarUIView?.isHidden = true
        //absoluteWidth = UIScreen.main.bounds.height
    }
}

//код для покраски статус бара (заимствован)
extension UIApplication {
var statusBarUIView: UIView? {
    if #available(iOS 13.0, *) {
        let tag = 3848245
        let keyWindow = UIApplication.shared.connectedScenes
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows.first
        if let statusBar = keyWindow?.viewWithTag(tag) {
            return statusBar
        } else {
            let height = keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
            let statusBarView = UIView(frame: height)
            statusBarView.tag = tag
            statusBarView.layer.zPosition = 999999

            keyWindow?.addSubview(statusBarView)
            return statusBarView
        }
    } else {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
    }
    return nil
  }
}

class MainTabBarController: UITabBarController {

    let firstVC = CollectionViewController()
    //let secondVC = ProfileViewController()
    let secondVC = FavoritesViewController()
    
    func findNavigationBarHeight() -> CGFloat {
        if let height = secondVC.navigationController?.navigationBar.frame.height {
            return height //k2
        } else { return 0 }
    }
    
    func findTabBarHeight() -> CGFloat {
        if let height = self.tabBarController?.tabBar.frame.height {
            return height //k3
        } else { return 0 }
    }
    
    func findStatusBarHeight() -> CGFloat {  //k1
        return UIApplication.shared.statusBarFrame.size.height
    }

    override func viewDidLoad() {
        setupControllers()
        super.viewDidLoad()
        
        //вычисляем высоту NavigationBar и StatusBar для сдвига элементов Profile
        topBarHeight = findNavigationBarHeight() + findStatusBarHeight()
        //красим все бары в один цвет
        UINavigationBar.appearance().backgroundColor = .systemGray6
        //UIBarButtonItem.appearance().tintColor = UIColor.magenta
        UITabBar.appearance().backgroundColor = .systemGray6
    }
    
    func setupControllers() {
        firstVC.tabBarItem.title = "Collection"
        firstVC.tabBarItem.image = UIImage(systemName: "rectangle.grid.2x2")
        firstVC.navigationItem.title = "Main Collection"
        secondVC.tabBarItem.title = "Favorites"
        secondVC.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        secondVC.navigationItem.title = "Favorites"
        let firstNavigationVC = UINavigationController(rootViewController: firstVC)
        let secondNavigationVC = UINavigationController(rootViewController: secondVC)
        viewControllers = [firstNavigationVC, secondNavigationVC]
    }
}
