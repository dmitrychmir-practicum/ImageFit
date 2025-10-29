//
//  OAuth2TokenStorage.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 27.10.2025.
//

import Foundation

final class OAuth2TokenStorage {
    private let tokenKey = "unsplashUserToken"
    
    var token: String? {
        get {
            UserDefaults.standard.string(forKey: tokenKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: tokenKey)
        }
    }
}
