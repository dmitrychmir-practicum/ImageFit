//
//  URLSession.data+Extension.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 27.10.2025.
//

import UIKit

extension URLSession {
    func data(for request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionTask {
        let fulfillCompletionOnTheMainThread: (Result<Data, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        let task = dataTask(with: request, completionHandler: { data, response, error in
            if let data, let response, let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if 200..<300 ~= statusCode {
                    fulfillCompletionOnTheMainThread(.success(data))
                } else {
                    fulfillCompletionOnTheMainThread(.failure(NetworkError.httpStatusCode(statusCode)))
                }
            } else if let error {
                fulfillCompletionOnTheMainThread(.failure(NetworkError.urlRequestError(error)))
            } else {
                fulfillCompletionOnTheMainThread(.failure(NetworkError.urlSessionError))
            }
        })
        
        return task
    }
    
    func objectTask(for request: URLRequest, completion: @escaping (Result<OAuthTokenResponseBody, Error>) -> Void) -> URLSessionTask {
        let task = data(for: request) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                do {
                    let decodedObject = try Decoder.jsonDataWithSeconds.decoder.decode(OAuthTokenResponseBody.self, from: data)
                    completion(.success(decodedObject))
                } catch {
                    Logger.shared.insertLog(.decodeError(method: "URLSession.objectTask", error: error, content: String(data: data, encoding: .utf8) ?? ""))
                    completion(.failure(error))
                }
            case .failure(let error):
                Logger.shared.insertLog(.requestError(method: "URLSession.objectTask", error: error))
                completion(.failure(error))
            }
        }
        
        return task
    }
    
    func objectTask<T: Decodable>(for request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionTask {
        let task = data(for: request) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                do {
                    let decodedObject = try Decoder.jsonDataWithIso8601.decoder.decode(T.self, from: data)
                    completion(.success(decodedObject))
                } catch {
                    Logger.shared.insertLog(.decodeError(method: "URLSession.objectTask", error: error, content: String(data: data, encoding: .utf8) ?? ""))
                    completion(.failure(error))
                }
            case .failure(let error):
                Logger.shared.insertLog(.requestError(method: "URLSession.objectTask", error: error))
                completion(.failure(error))
            }
        }
        
        return task
    }
    
    func objectTask(for request: URLRequest, completion: @escaping (Result<[PhotoResult], Error>) -> Void) -> URLSessionTask {
        let task = data(for: request) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                do {
                    let decodedObject = try Decoder.jsonDataWithIso8601.decoder.decode([PhotoResult].self, from: data)
                    completion(.success(decodedObject))
                } catch {
                    Logger.shared.insertLog(.decodeError(method: "URLSession.objectTask", error: error, content: String(data: data, encoding: .utf8) ?? ""))
                    completion(.failure(error))
                }
            case .failure(let error):
                Logger.shared.insertLog(.requestError(method: "URLSession.objectTask", error: error))
                completion(.failure(error))
            }
        }
        
        return task
    }
    
    func requestTask(for request: URLRequest, completion: @escaping (Result<Void, Error>) -> Void) -> URLSessionTask {
        //TODO: Проверить возможность избавиться от Data
        let task = data(for: request) { (result: Result<Data, Error>) in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                Logger.shared.insertLog(.requestError(method: "URLSession.objectTask", error: error))
                completion(.failure(error))
            }
        }
        
        return task
    }
}
