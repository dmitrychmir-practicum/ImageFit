//
//  SplashViewController.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 27.10.2025.
//

import UIKit

final class SplashViewController: UIViewController {
    let showAuthViewIdentifier = "showAuthView"
    private let storage = OAuth2TokenStorage()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if storage.token != nil {
            switchToTabBarController()
        } else {
            performSegue(withIdentifier: showAuthViewIdentifier, sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        view.backgroundColor = .ypBlack
        let logoImage = UIImage(resource: .splashScreenLogo)
        let logoImageView = UIImageView(image: logoImage)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
            
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            logoImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 0),
        ])
        
    }
    
    func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else {
            fatalError("Ошибка конфигурации")
        }
        
        let tabBarController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "tabBarViewController")
        window.rootViewController = tabBarController
    }
}
