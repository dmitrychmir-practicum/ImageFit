//
//  NetworkClient.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 27.10.2025.
//

import Foundation
//TODO: Ссылок на структуру у нас не осталось, возможно стоит удалить
struct NetworkClient: NetworkRoutingProtocol {
    private let logger = Logger.shared
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchData(request: URLRequest, handler: @escaping (Result<Data, Error>) -> Void) {
        let task = fetchDataTask(request: request, handler: handler)
        task.resume()
    }
    
    func fetchDataTask(request: URLRequest, handler: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask {
        let fulfillHandlerOnTheMainThread: (Result<Data, Error>) -> Void = { result in
            DispatchQueue.main.async {
                handler(result)
            }
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error {
                logger.insertLog(error)
                fulfillHandlerOnTheMainThread(.failure(error))
                return
            }
            
            guard let resp = response as? HTTPURLResponse else {
                let respErr = NetworkError.invalidRequest
                logger.insertLog(respErr)
                fulfillHandlerOnTheMainThread(.failure(respErr))
                return
            }

            guard (200..<300).contains(resp.statusCode) else {
                if resp.statusCode == 404 {
                    let statErr = NetworkError.httpStatusCode(resp.statusCode)
                    logger.insertLog("Контент не найден")
                    fulfillHandlerOnTheMainThread(.failure(statErr))
                    return
                }
                
                let statErr = NetworkError.httpStatusCode(resp.statusCode)
                logger.insertLog(statErr)
                fulfillHandlerOnTheMainThread(.failure(statErr))
                return
            }
            
            guard let data else {
                let emptyError = NetworkError.emptyData
                logger.insertLog(emptyError)
                fulfillHandlerOnTheMainThread(.failure(emptyError))
                return
            }
            
            fulfillHandlerOnTheMainThread(.success(data))
        }
        
        return task
    }
}
