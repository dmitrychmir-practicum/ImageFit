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
                self.logger.insertLog("[AuthViewController.webViewViewController]: Ошибка при аутентификации: \(error.localizedDescription)")
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
        let alertController = UIAlertController(title: "Что-то пошло не так", message: "Не удалось войти в систему", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
