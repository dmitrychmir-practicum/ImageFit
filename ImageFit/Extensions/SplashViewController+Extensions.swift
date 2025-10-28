//
//  SplashViewController+Extensions.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 27.10.2025.
//

import UIKit

extension SplashViewController: AuthViewControllerDelegate {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showAuthViewIdentifier {
            guard let navController = segue.destination as? UINavigationController, let viewController = navController.viewControllers[0] as? AuthViewController
            else {
                fatalError("Не удалось создать окно для \(showAuthViewIdentifier)")
            }
            viewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    func didAuthenticate(_ viewController: AuthViewController) {
        navigationController?.popViewController(animated: true)
        switchToTabBarController()
    }
}
