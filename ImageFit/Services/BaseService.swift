//
//  BaseService.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 02.11.2025.
//

import Foundation

class BaseService {
    let logger = Logger.shared
    let urlSession = URLSession.shared
    let storage = OAuth2TokenStorage()
    var task: URLSessionTask?
}
