//
//  ProfileImageService.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 03.11.2025.
//

import UIKit

final class ProfileImageService: BaseService {
    static let shared = ProfileImageService()
    static let didChangeNotification = Notification.Name("ProfileImageProviderDidChange")
    private let networkClient = NetworkClient()
    private(set) var avatarURL: String?
    
    private override init() {}
    
    func fetchProfileImageUrl(username: String, _ completion: @escaping (Result<String, Error>) -> Void) {
        assert(Thread.isMainThread)
        task?.cancel()
        
        guard let token = storage.token,
              let request = createGetUserRequest(withToken: token, user: username) else {
            logger.insertLog("Не удалось создать запрос профиля")
            completion(.failure(ProfileServiceError.failedToFetchProfileInfo))
            return
        }
        
        let task = URLSession.shared.objectTask(for: request) { [weak self] (result: Result<UserResult, Error>) in
            guard let self else { return }
            switch result {
            case .success(let result):
                self.avatarURL = result.profileImage.large
                completion(.success(result.profileImage.large))
                
                NotificationCenter.default.post(name: ProfileImageService.didChangeNotification, object: self, userInfo: ["URL": self.avatarURL ?? ""])
                case .failure(let error):
                self.logger.insertLog(error)
                completion(.failure(error))
            }
        }
        
        self.task = task
        task.resume()
    }
    
    private func createGetUserRequest(withToken token: String, user: String) -> URLRequest? {
        guard let urlComponents = URLComponents(string: UnsplashProfileURL.user(username: user).url),
              let url = urlComponents.url else {
            logger.insertLog("Ошибка: не удалось создать URL запроса личной информации")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = HTTPMethod.get.rawValue
        
        return request
    }
}
