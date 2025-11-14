//
//  ProfileLogoutService.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 13.11.2025.
//

import Foundation
import WebKit

final class ProfileLogoutService: BaseService {
    static let shared = ProfileLogoutService()
    private let profileService: RemoveDataDelegate = ProfileService.shared
    private let profileImageService: RemoveDataDelegate = ProfileImageService.shared
    private let imagesListService: RemoveDataDelegate = ImagesListService.shared
    
    private override init() {}
    
    func logout() {
        cleanCookies()
        cleanToken()
        cleanProfile()
        cleanImagesList()
    }
    
    private func cleanCookies() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }
    
    private func cleanProfile() {
        profileService.removeCurrentData()
        profileImageService.removeCurrentData()
    }
    
    private func cleanImagesList() {
        imagesListService.removeCurrentData()
    }
    
    private func cleanToken() {
        self.storage.removeCurrentData()
    }
}
