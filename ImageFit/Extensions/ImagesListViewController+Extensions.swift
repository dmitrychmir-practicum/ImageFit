//
//  ImagesListViewController+Extensions.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 05.10.2025.
//

import UIKit

extension ImagesListViewController:  UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        
        guard let imagesListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        
        configCell(for: imagesListCell, with: indexPath)
        
        return imagesListCell
    }
}

extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifier, sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let currentCellHeight = heightOfCells[indexPath] {
            return currentCellHeight
        }
        
        let photoModel = photos[indexPath.row]
        let width = tableView.bounds.width - insets.left - insets.right
        let scale = width / CGFloat(photoModel.size.width)
        let height = CGFloat(photoModel.size.height) * scale + insets.top + insets.bottom
        
        heightOfCells[indexPath] = height
        
        return height
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == photos.count {
            UIBlockingProgressHUD.show()
            imagesListService.fetchPhotosNextPage() { _ in }
        }
    }
}

extension ImagesListViewController: ImagesListCellDelegate {
    func didTapLike(_ cell: ImagesListCell) {
        guard let index = tableView.indexPath(for: cell) else {
            return
        }
        let photoModel = photos[index.row]
        changeLike(photoModel: photoModel, cell: cell, indexRow: index.row)
    }
    
    private func changeLike(photoModel: PhotoModel, cell: ImagesListCell, indexRow: Int) {
        UIBlockingProgressHUD.show()
        imagesListService.changeLike(photoId: photoModel.id, isLike: photoModel.isLiked) { [weak self] result in
            guard let self else { return }
            UIBlockingProgressHUD.dismiss()
            
            switch result {
            case .success:
                self.photos[indexRow].isLiked = !self.photos[indexRow].isLiked
                cell.setLikeButtonImage(self.photos[indexRow].isLiked)
            case .failure(let error):
                self.logger.insertLog(.changeLikeStatusError(method: "ImagesListViewController.changeLike", error: error))
                let alert = Alert.yesNoAlert(title: AnyErrorAlertConstants.title, message: AnyErrorAlertConstants.message, style: .alert, completionYes: {
                    self.changeLike(photoModel: photoModel, cell: cell, indexRow: indexRow)
                }, completionNo: nil)
                present(alert.controller, animated: true)
            }
        }
    }
}
