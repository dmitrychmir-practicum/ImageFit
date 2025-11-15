//
//  OAuth2Service.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 27.10.2025.
//

import UIKit

final class OAuth2Service : BaseService {
    static let shared = OAuth2Service()
    private var lastCode: String?
    
    private override init() {}
    
    func fetchAuthToken(withCode code: String, completion: @escaping (Result<String, Error>) -> Void) {
        assert(Thread.isMainThread)
        if lastCode != code {
            completion(.failure(NetworkError.invalidRequest))
        }
        
        task?.cancel()
        lastCode = code
        
        guard let request = createOAuthTokenRequest(withCode: code) else {
            completion(.failure(AuthServiceError.invalidRequest))
            return
        }

        let task = urlSession.objectTask(for: request) {[weak self] (result: Result<OAuthTokenResponseBody, Error>) in
            DispatchQueue.main.async {
                UIBlockingProgressHUD.dismiss()
                guard let self else { return }
                
                switch result {
                case .success(let body):
                    let authToken = body.accessToken
                    self.storage.token = authToken
                    completion(.success(authToken))
                case .failure(let error):
                    self.logger.insertLog(.requestError(method: "OAuth2Service.fetchAuthToken", error: error))
                    completion(.failure(error))
                }
                self.task = nil
                self.lastCode = nil
            }
        }
        
        self.task = task
        task.resume()
    }
    
    private func createOAuthTokenRequest(withCode code: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: "https://unsplash.com/oauth/token") else {
            logger.insertLog(.urlError(method: "OAuth2Service.createOAuthTokenRequest"))
            
            return nil
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "client_secret", value: Constants.secretKey),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectUri)
        ]
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        
        return request
    }
}
