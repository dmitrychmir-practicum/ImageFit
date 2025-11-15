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
    let isLiked: Bool
    
    func setLikeStatus(_ isLike: Bool) -> PhotoModel {
        let newPhoto = PhotoModel(id: id, size: size, createdAt: createdAt, welcomeDescription: welcomeDescription, thumbImageURL: thumbImageURL, largeImageURL: largeImageURL, isLiked: isLike)
        return newPhoto
    }
}

struct PhotoResult: Decodable {
    let id: String
    let createdAt: Date?
    let updatedAt: Date?
    let width: Int
    let height: Int
    let color: String
    let blurHash: String
    let likes: Int
    let likedByUser: Bool
    let description: String?
    let urls: PhotoUrls?
}

struct PhotoUrls: Decodable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}
