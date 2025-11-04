//
//  Profile+Extensions.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 03.11.2025.
//

extension ProfileResult {
    func toModel() -> ProfileModel {
        let model = ProfileModel(
            username: username, fullName: "\(firstName) \(lastName)", loginName: "@\(username)", bio: bio)
        return model
    }
}
