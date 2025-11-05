//
//  ProfileModels.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 01.11.2025.
//

import Foundation

struct ProfileModel {
    var username: String
    var fullName: String
    var loginName: String
    var bio: String?
}

struct ProfileResult: Decodable {
    var username: String
    var firstName: String
    var lastName: String
    var bio: String?
}

struct UserResult: Decodable {
    var profileImage: ProfileImage
}

struct ProfileImage: Decodable {
    var small: String
    var medium: String
    var large: String
}
