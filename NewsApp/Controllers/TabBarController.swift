//
//  TabBarController.swift
//  NewsApp
//
//  Created by Evgenii Mikhailov on 15.02.2023.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [createNavigationController(viewController: NewsViewController(), title: "Новости", image: "newspaper"),
                           createNavigationController(viewController: MapViewController(), title: "Карта", image: "location"),
                           createNavigationController(viewController: FavoritesViewController(), title: "Избранное", image: "heart"),
                           createNavigationController(viewController: ProfileViewController(), title: "Профиль", image: "profile")
                           ]
    }
    
    fileprivate func createNavigationController( viewController: UIViewController, title: String , image: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = false
        navController.tabBarItem.title = title
        navController.tabBarController?.tabBar.tintColor = UIColor(named: "Color")
        navController.view.backgroundColor = UIColor(named: "background")
        navController.tabBarItem.image = UIImage(named: image)
        navController.navigationBar.backgroundColor = UIColor(named: "background")
        navController.navigationBar.isHidden = true
        return navController
    }
}
