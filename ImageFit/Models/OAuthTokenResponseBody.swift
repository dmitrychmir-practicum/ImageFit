//
//  OAuthTokenResponseBody.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 27.10.2025.
//

import Foundation

struct OAuthTokenResponseBody: Decodable {
    let accessToken: String
    let tokenType: String
    let scope: String
    let createdAt: Date
}
