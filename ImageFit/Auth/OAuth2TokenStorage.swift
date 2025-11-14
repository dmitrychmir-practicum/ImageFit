//
//  OAuth2TokenStorage.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 27.10.2025.
//

import Foundation
import SwiftKeychainWrapper

final class OAuth2TokenStorage {
    private let logger = Logger.shared
    private let tokenKey = "unsplashUserToken"
    
    var token: String? {
        get {
            KeychainWrapper.standard.string(forKey: tokenKey)
        } set {
            if let token = newValue {
                KeychainWrapper.standard.set(token, forKey: tokenKey)
            } else {
                KeychainWrapper.standard.removeObject(forKey: tokenKey)
            }
        }
    }
}

extension OAuth2TokenStorage: RemoveDataDelegate {
    func removeCurrentData() {
        let isRemoved = KeychainWrapper.standard.removeObject(forKey: tokenKey)
        
        if isRemoved {
            logger.insertLog("Токен пользователя очищен.")
        } else {
            logger.insertLog("Не удалось удалить токен пользователя.")
        }
    }
}
