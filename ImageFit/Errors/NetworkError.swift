//
//  NetworkError.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 27.10.2025.
//

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
    case invalidRequest
    case decodingError(Error)
    case emptyData
}
