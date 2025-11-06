//
//  Constants.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 23.10.2025.
//

import UIKit

enum Constants {
    static let accessKey = "Dz2eW520QQySHTzsvBY4cWw9bekdZ1koM4UZWJ6KH4s"
    static let secretKey = "ZF9NTGaqpTRSwkJv_8EFFvdXdkF0xYyvUH4EIpBuvrc"
    static let redirectUri = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "public+read_user+write_likes"
    static let defaultBaseURL = URL(string: "https://api.unsplash.com")
}

enum WebViewConstants {
    static let unsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
}

enum UnsplashProfileURL {
    case me
    case user(username: String)
    
    var url: String {
        switch self {
        case .me:
            return "https://api.unsplash.com/me"
        case .user(let username):
            return "https://api.unsplash.com/users/\(username)"
        }
    }
}

enum ImagesDownloaderConstants {
    case page(page: Int, pageSize: Int)
    
    var url: String {
        switch self {
            case .page(page: let page, pageSize: let pageSize):
            return "https://api.unsplash.com/photos?page=\(page)&per_page=\(pageSize)"
        }
    }
}

enum AuthErrorAlertConstants {
    static let title = "Что-то пошло не так"
    static let message = "Не удалось войти в систему"
}

enum ErrorMessages {
    case requestError(method: String, error: Error)
    case urlError(method: String)
    
    var description: String {
        switch self {
        case .requestError(let method, let error):
            return "[\(method)]: Ошибка запроса: \(error.localizedDescription)"
        case .urlError(let method):
            return "[\(method)]: Ошибка: не удалось создать URL"
        }
    }
}
