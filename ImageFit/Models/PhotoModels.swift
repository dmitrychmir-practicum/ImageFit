//
//  PhotoModels.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 06.11.2025.
//

import Foundation

struct PhotoModel {
    let id: String
    let size: CGSize
    let createdAt: Date?
    let welcomeDescription: String?
    let thumbImageURL: String?
    let largeImageURL: String?
    var isLiked: Bool
}

struct PhotoResult: Decodable {
    let id: String
    let createdAt: String?
    let updatedAt: String?
    let width: Int
    let height: Int
    let color: String
    let blurHash: String
    let likes: Int
    let likedByUser: Bool
    let description: String?
    let user: PhotoUser?
    let currentUserCollections: [CurrentUserCollectionItem]
    let urls: PhotoUrls?
    let links: PhotoLinks?
}

struct PhotoUser: Decodable {
    let id: String
    let username: String?
    let name: String?
    let portfolioUrl: String?
    let bio: String?
    let location: String?
    let totalLikes: Int
    let totalPhotos: Int
    let totalCollections: Int
    let instagramUsername: String?
    let twitterUsername: String?
    let profileImage: ProfileImage?
    let links: PhotoLinks?
}

struct CurrentUserCollectionItem: Decodable {
    let id: Int
    let title: String
    let publishedAt: String?
    let lastCollectedAt: String?
    let updatedAt: String?
    let coverPhoto: String?
    let user: String?
}

struct PhotoUrls: Decodable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

struct PhotoLinks: Decodable {
    let `self`: String
    let html: String
    let photos: String?
    let likes: String?
    let portfolio: String?
}
