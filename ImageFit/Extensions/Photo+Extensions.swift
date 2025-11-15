//
//  Photo+Extensions.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 06.11.2025.
//

import UIKit


extension PhotoResult {
    func toModel() -> PhotoModel {
        PhotoModel(id: id,
            size: CGSize(width: width, height: height),
            createdAt: createdAt,
            welcomeDescription: description,
            thumbImageURL: urls?.thumb,
            largeImageURL: urls?.full,
            isLiked: likedByUser
        )
    }
}

extension [PhotoResult] {
    func toModels() -> [PhotoModel] {
        map { $0.toModel() }
    }
}
