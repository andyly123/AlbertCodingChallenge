//
//  TabBarController.swift
//  OpenLibrary
//
//  Created by Mac on 6/16/19.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
    }
    
    // Mark: - Helper Functions
    private func setupViewControllers() {
        
        let searchController = SearchController()
        let searchNavController = UINavigationController(rootViewController: searchController)
        searchNavController.tabBarItem.image = UIImage(named: "icon_search")
        
        let wishListController = WishListController()
        let wishNavController = UINavigationController(rootViewController: wishListController)
        wishNavController.tabBarItem.image = UIImage(named: "icon_list")
        
        self.viewControllers = [searchNavController, wishNavController]
        
        // Center the tab bar icons
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
}
