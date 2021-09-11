//
//  TabBarViewController.swift
//  TabBarViewController
//
//  Created by Dipak Pandey on 10/09/21.
//

import UIKit

enum TabBarItems: Int, CaseIterable {
    case profile
    case weather
    
    var title: String? {
        switch self {
        case .profile:
            return "Profile"
            
        case .weather:
            return "Weather"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .profile:
            return UIImage(systemName: "person")
        case .weather:
            return UIImage(systemName: "cloud")
        }
    }
    
    var navigationController: UINavigationController {
        let navigation = UINavigationController()
        navigation.tabBarItem.title = self.title
        navigation.tabBarItem.image = self.icon
        navigation.setNavigationBarHidden(true, animated: true)

        return navigation
    }
}

class TabBarViewController: UITabBarController, StoryboardInitializable {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
