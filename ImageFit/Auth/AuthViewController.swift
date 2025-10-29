//
//  AuthViewController.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 23.10.2025.
//

import UIKit

final class AuthViewController: UIViewController {
    private let oauth2Service = OAuth2Service.shared
    private let showWebViewIdentifier = "showWebView"
    let authStorage = OAuth2TokenStorage()
    let logger = Logger.shared
    weak var delegate: AuthViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackButton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showWebViewIdentifier {
            guard let webViewController = segue.destination as? WebViewViewController else {
                assertionFailure("Невозможно создать переход \(showWebViewIdentifier)")
                return
            }
            
            webViewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    private func configureBackButton() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(resource: .navBackButton)
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(resource: .navBackButton)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .ypBlack
    }
}
