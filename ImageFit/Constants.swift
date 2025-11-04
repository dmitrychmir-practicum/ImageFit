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
