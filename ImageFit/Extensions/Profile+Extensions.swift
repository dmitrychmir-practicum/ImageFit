//
//  Profile+Extensions.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 03.11.2025.
//

import Foundation

extension ProfileResult {
    func toModel() -> ProfileModel {
        let model = ProfileModel(
            username: username,
            fullName: "\(firstName) \(lastName)".trimmingCharacters(in: .whitespaces),
            loginName: "@\(username)", bio: bio)
        return model
    }
}
