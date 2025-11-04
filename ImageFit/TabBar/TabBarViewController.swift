//
//  TabBarViewController.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 08.10.2025.
//

import UIKit

final class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let imagesListViewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController")
        let profileViewController = ProfileViewController()
        profileViewController.view.backgroundColor = .ypBlack
        profileViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(resource: .tabProfileActive), selectedImage: nil)
        
        self.viewControllers = [imagesListViewController, profileViewController]
    }
}
