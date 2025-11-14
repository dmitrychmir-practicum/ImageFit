//
//  Photo+Extensions.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 06.11.2025.
//

import UIKit


extension PhotoResult {
    func toModel() -> PhotoModel {
        return PhotoModel(id: self.id,
                          size: CGSize(width: self.width, height: self.height),
                          createdAt: self.createdAt,
                          welcomeDescription: self.description,
                          thumbImageURL: self.urls?.thumb,
                          largeImageURL: self.urls?.full,
                          isLiked: self.likedByUser
        )
    }
}

extension [PhotoResult] {
    func toModels() -> [PhotoModel] {
        var result = [PhotoModel]()
        for item in self {
            let model = item.toModel()
            result.append(model)
        }
        
        return result
    }
}
