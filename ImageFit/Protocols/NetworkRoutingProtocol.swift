//
//  NetworkRoutingProtocol.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 27.10.2025.
//

import Foundation

protocol NetworkRoutingProtocol {
    func fetchData(request: URLRequest, handler: @escaping (Result<Data, Error>) -> Void)
}
