//
//  OAuth2Service.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 27.10.2025.
//

import UIKit

final class OAuth2Service {
    private let logger = Logger.shared
    static let shared = OAuth2Service()
    private let networkClient = NetworkClient()
    private let decoder = JSONDecoder()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func fetchAuthToken(withCode code: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let request = createOAuthTokenRequest(withCode: code) else {
            completion(.failure(NetworkError.invalidRequest))
            return
        }
        
        networkClient.fetchData(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let jsonData = try self.decoder.decode(OAuthTokenResponseBody.self, from: data)
                    completion(.success(jsonData.accessToken))
                } catch {
                    self.logger.insertLog(error)
                    completion(.failure(error))
                }
            case .failure(let error):
                self.logger.insertLog(error)
                completion(.failure(error))
            }
        
        }
    }
    
    private func createOAuthTokenRequest(withCode code: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: "https://unsplash.com/oauth/token") else {
            logger.insertLog("Ошибка: не удалось создать URL")
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
            logger.insertLog("Ошибка: не удалось создать URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        
        return request
    }
}
