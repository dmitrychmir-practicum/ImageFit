//
//  AuthViewController+Extensions.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 23.10.2025.
//

import UIKit
import ProgressHUD

extension AuthViewController: WebViewViewControllerDelegate {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        navigationController?.popViewController(animated: true)
        UIBlockingProgressHUD.show()
        
        oauth2Service.fetchAuthToken(withCode: code) { [weak self] result in
            UIBlockingProgressHUD.dismiss()
            guard let self else { return }
            
            switch result {
            case .success(let token):
                self.authStorage.token = token
                self.delegate?.didAuthenticate(self)
            case .failure(let error):
                self.logger.insertLog(.authError(method: "AuthViewController.didAuthenticateWithCode", error: error))
                self.showAuthErrorAlert()
            }
            UIBlockingProgressHUD.dismiss()
        }
    }
    
    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        vc.dismiss(animated: true)
    }
}

extension AuthViewController {
    func showAuthErrorAlert() {
        let alert = Alert.simpleAlert(title: AuthErrorAlertConstants.title, message: AuthErrorAlertConstants.message, style: .alert, completion: nil)
        
        present(alert.controller, animated: true, completion: nil)
    }
}
