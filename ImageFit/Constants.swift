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

enum ImageLikeUrl {
    case like(photoId: String)
    
    var url: String {
        switch self {
        case .like(photoId: let id):
            return "https://api.unsplash.com/photos/\(id)/like"
        }
    }
}

enum AuthErrorAlertConstants {
    static let title = "Что-то пошло не так"
    static let message = "Не удалось войти в систему"
}

enum AnyErrorAlertConstants {
    static let title = "Ошибка"
    static let message = "Что-то пошло не так. Попробовать ещё раз?"
}

enum ErrorMessages {
    case requestError(method: String, error: Error)
    case urlError(method: String)
    case authError(method: String, error: Error)
    case changeLikeStatusError(method: String, error: Error)
    case loadSingleImageError(method: String, error: Error)
    case decodeError(method: String, error: Error, content: String)
    
    var description: String {
        switch self {
        case .requestError(let method, let error):
            return "[\(method)]: Ошибка запроса: \(error.localizedDescription)"
        case .urlError(let method):
            return "[\(method)]: Ошибка: не удалось создать URL"
        case .authError(let method, let error):
            return "[\(method)]: Ошибка при аутентификации: \(error.localizedDescription)"
        case .changeLikeStatusError(let method, let error):
            return "[\(method)]: Ошибка: не удалось сменить статус изображения: \(error.localizedDescription)"
        case .loadSingleImageError(let method, let error):
            return "[\(method)]: Ошибка: не удалось загрузить изображение: \(error.localizedDescription)"
        case .decodeError(let method, let error, let content):
            if let decodingError = error as? DecodingError {
                return "[\(method)]: Ошибка декодирования: \(decodingError), Данные: \(content)"
            } else {
                return "[\(method)]: Ошибка декодирования: \(error.localizedDescription), Данные: \(content)"
            }
        }
    }
}

enum Alert {
    case simpleAlert(title: String, message: String, style: UIAlertController.Style, completion: (() -> Void)? = nil)
    case yesNoAlert(title: String, message: String, style: UIAlertController.Style, completionYes: (() -> Void)? = nil, completionNo: (() -> Void)? = nil)
    
    var controller: UIAlertController {
        switch self {
        case .simpleAlert(let title, let message, let style, _):
            let ac = UIAlertController(title: title, message: message, preferredStyle: style)
            let action = UIAlertAction(title: "OK", style: .default)
            ac.addAction(action)
            return ac
        case .yesNoAlert(let title, let message, let style, let completionYes, let completionNo):
            let ac = UIAlertController(title: title, message: message, preferredStyle: style)
            let actionYes = UIAlertAction(title: "Да", style: .default) { _ in
                guard let completionYes else { return }
                completionYes()
            }
            let actionNo = UIAlertAction(title: "Нет", style: .cancel) { _ in
                guard let completionNo else { return }
                completionNo()
            }
            ac.addAction(actionYes)
            ac.addAction(actionNo)
            return ac
        }
    }
}

enum Decoder {
    case json
    
    private static let jsDecoder = JSONDecoder()
    
    var decoder: JSONDecoder {
        Decoder.jsDecoder.keyDecodingStrategy = .convertFromSnakeCase
        Decoder.jsDecoder.dateDecodingStrategy = .iso8601
        
        return Decoder.jsDecoder
    }
}
