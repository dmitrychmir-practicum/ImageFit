//
//  ImagesListService.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 06.11.2025.
//

import UIKit

final class ImagesListService: BaseService {
    
    static let shared = ImagesListService()
    private let pageSize = 10
    private var lastLoadedPage: Int?
    private(set) var photos: [PhotoModel] = []
    
    static let didChangeNotification = Notification.Name("ImagesListServiceDidChange")
    
    override private init() {}

    func fetchPhotosNextPage(_ completion: @escaping (Result<[PhotoModel], Error>) -> Void) {
        assert(Thread.isMainThread)
        task?.cancel()
        
        let nextPage = (lastLoadedPage ?? 0) + 1
        guard let token = storage.token,
              let request = createGetPhotosRequest(withToken: token, andPage: nextPage) else {
            completion(.failure(NSError(domain: "ImagesListService.fetchPhotosNextPage", code: 401, userInfo: [NSLocalizedDescriptionKey: "Authorization token missing"])))
            return
        }
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<[PhotoResult], Error>) in
            guard let self else { return }
            switch result {
            case .success(let result):
                let photosLoaded = result.toModels()
                photos.append(contentsOf: photosLoaded)
                self.lastLoadedPage = nextPage
                completion(.success(photosLoaded))
                NotificationCenter.default.post(name: ImagesListService.didChangeNotification, object: self, userInfo: ["Images": photosLoaded])
            case .failure(let error):
                self.logger.insertLog(.requestError(method: "ImagesListService.fetchPhotosNextPage", error: error))
                
                completion(.failure(error))
            }
        }
        
        self.task = task
        task.resume()
    }
    
    func changeLike(photoId: String, isLike: Bool, _ completion: @escaping (Result<Void, Error>) -> Void) {
        assert(Thread.isMainThread)
        task?.cancel()
        
        guard let token = storage.token,
              let request = createChangeLikeRequest(withToken: token, photoId: photoId, isLike: isLike) else {
            completion(.failure(NSError(domain: "ImagesListService.changeLike", code: 401, userInfo: [NSLocalizedDescriptionKey: "Authorization token missing"])))
            return
        }
        
        let task = urlSession.requestTask(for: request) { [weak self] (result: Result<Void, Error>) in
            guard let self else { return }
            switch result {
            case .success:
                if let photoIndex = self.photos.firstIndex(where: { $0.id == photoId }) {
                    var photo = self.photos[photoIndex]
                    photo = photo.setLikeStatus(!isLike)
                    self.photos[photoIndex] = photo
                }
                completion(.success(()))
            case .failure(let error):
                self.logger.insertLog(.requestError(method: "ImagesListService.changeLike", error: error))
                
                completion(.failure(error))
            }
        }
        
        self.task = task
        task.resume()
    }
    
    private func createGetPhotosRequest(withToken token: String, andPage page: Int) -> URLRequest? {
        guard let url = URL(string: ImagesDownloaderConstants.page(page: page, pageSize: pageSize).url) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = HTTPMethod.get.rawValue
        
        return request
    }
    
    private func createChangeLikeRequest(withToken token: String, photoId: String, isLike: Bool) -> URLRequest? {
        guard let url = URL(string: ImageLikeUrl.like(photoId: photoId).url) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = !isLike ? HTTPMethod.post.rawValue : HTTPMethod.delete.rawValue
        
        return request
    }
}

extension ImagesListService: RemoveDataDelegate {
    func removeCurrentData() {
        photos = []
    }
}
