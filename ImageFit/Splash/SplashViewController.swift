//
//  SplashViewController.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 27.10.2025.
//

import UIKit

final class SplashViewController: UIViewController {
    let showAuthViewIdentifier = "showAuthView"
    let storage = OAuth2TokenStorage()
    let profileService = ProfileService.shared
    let imagesListService = ImagesListService.shared
    let logger = Logger.shared

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let token = storage.token {
            fetchProfile(withToken: token)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            
            guard let authViewController = storyboard.instantiateViewController(withIdentifier: "AuthViewController") as? AuthViewController else {
                logger.insertLog("AuthViewController not found")
                return
            }
            authViewController.delegate = self
            authViewController.modalPresentationStyle = .fullScreen
            present(authViewController, animated: true)
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
