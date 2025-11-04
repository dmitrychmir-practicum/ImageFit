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
                assertionFailure("Не удалось создать окно для \(showAuthViewIdentifier)")
                return
            }
            viewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    func didAuthenticate(_ viewController: AuthViewController) {
        navigationController?.popViewController(animated: true)
        
        guard let token = storage.token else {
            return
        }
        
        fetchProfile(withToken: token)
        //switchToTabBarController()
    }
    
    internal func fetchProfile(withToken token: String) {
        UIBlockingProgressHUD.show()
        profileService.fetchProfile(token: token) { [weak self] result in
            UIBlockingProgressHUD.dismiss()
            switch result {
            case .success:
                self?.switchToTabBarController()
            case .failure(let error):
                //TODO: Показать ошибку загрузки профиля
                break
            }
        }
    }
}
