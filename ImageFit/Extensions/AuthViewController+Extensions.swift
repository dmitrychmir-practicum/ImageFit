//
//  AuthViewController+Extensions.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 23.10.2025.
//

import UIKit

extension AuthViewController: WebViewViewControllerDelegate {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        navigationController?.popViewController(animated: true)
        
        OAuth2Service.shared.fetchAuthToken(withCode: code) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let token):
                    self?.authStorage.token = token
                    self?.logger.insertLog("Токен сохранён.")
                    if let self {
                        self.delegate?.didAuthenticate(self)
                    }
                case .failure(let error):
                    self?.logger.insertLog(error.localizedDescription)
                }
            }
        }
    }
    
    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        vc.dismiss(animated: true)
    }
    
    
}
