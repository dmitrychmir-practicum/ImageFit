//
//  ProfileService.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 01.11.2025.
//

import UIKit

final class ProfileService: BaseService {
    static let shared = ProfileService()
    private let profileImageService = ProfileImageService.shared
    private(set) var profile: ProfileModel?
    
    private override init() {}
    
    func fetchProfile(token: String, completion: @escaping (Result<ProfileModel, Error>) -> Void) {
        assert(Thread.isMainThread)
        task?.cancel()
        
        guard let request = createGetMeRequest(withToken: token) else {
            completion(.failure(ProfileServiceError.failedToFetchProfileInfo))
            return
        }

        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<ProfileResult, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let body):
                    let profile = body.toModel()
                    self?.profileImageService.fetchProfileImageUrl(username: profile.username) { _ in }
                    self?.profile = profile
                    completion(.success(profile))
                case .failure(let error):
                    self?.logger.insertLog("[ProfileService.fetchProfile]: Ошибка запроса: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }
        
        self.task = task
        task.resume()
    }
    
    private func createGetMeRequest(withToken token: String) -> URLRequest? {
        guard let urlComponents = URLComponents(string: UnsplashProfileURL.me.url),
              let url = urlComponents.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = HTTPMethod.get.rawValue
        
        return request
    }
}
