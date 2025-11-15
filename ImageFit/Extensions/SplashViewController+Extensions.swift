//
//  SplashViewController+Extensions.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 27.10.2025.
//

import UIKit

extension SplashViewController: AuthViewControllerDelegate {
    func didAuthenticate(_ viewController: AuthViewController) {
        navigationController?.popViewController(animated: true)
        
        guard let token = storage.token else {
            return
        }
        
        fetchProfile(withToken: token)
    }
    
    internal func fetchProfile(withToken token: String) {
        UIBlockingProgressHUD.show()
        profileService.fetchProfile(token: token) { [weak self] result in
            UIBlockingProgressHUD.dismiss()
            switch result {
            case .success:
                self?.switchToTabBarController()
                self?.imagesListService.fetchPhotosNextPage { _ in }
            case .failure(let error):
                self?.logger.insertLog(.requestError(method: "SplashViewController.fetchProfile", error: error))
                break
            }
        }
    }
}
