//
//  ViewController.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 04.10.2025.
//

import UIKit
import Kingfisher

final class ImagesListViewController: UIViewController {

    let imagesListService = ImagesListService.shared
    @IBOutlet
    var tableView: UITableView!
    private var imagesListServiceObserver: NSObjectProtocol?
    let logger = Logger.shared
    let segueIdentifier: String = "ShowSingleImage"
    var photos: [PhotoModel] = []
    var heightOfCells = [IndexPath: CGFloat]()
    let insets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        initObserverForImagesList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            guard
                let viewController = segue.destination as? SingleImageViewController,
                let indexPath = sender as? IndexPath
            else {
                assertionFailure("Invalid seque destionation")
                return
            }
            
            UIBlockingProgressHUD.show()
            guard let urlStr = photos[indexPath.row].largeImageURL,
                  let url = URL(string: urlStr) else {
                return
            }
            prepareSingleImageViewController(for: viewController, with: url)
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }

    func configCell(for cell: ImagesListCell, with indexPath: IndexPath){
        let photoModel = photos[indexPath.row]
        guard let thumbImageURL = photoModel.thumbImageURL,
              let url = URL(string: thumbImageURL) else { return }
        
        cell.delegate = self
        cell.configCell(url, date: photoModel.createdAt, isLiked: photoModel.isLiked)
    }
    
    private func initTableView() {
        view.backgroundColor = .ypBlack
        tableView.backgroundColor = .ypBlack
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func initObserverForImagesList() {
        imagesListServiceObserver = NotificationCenter.default.addObserver(forName: ImagesListService.didChangeNotification, object: nil, queue: .main) { [weak self] _ in
            self?.updateTableView()
        }
    }
    
    private func updateTableView() {
        let currentListCount = photos.count
        let loadedCount = imagesListService.photos.count
        
        photos = imagesListService.photos
        
        if currentListCount == loadedCount { return }
        
        tableView.performBatchUpdates {
            var paths = [IndexPath]()
            for i in (currentListCount..<loadedCount) {
                paths.append(IndexPath(row: i, section: 0))
            }
            tableView.insertRows(at: paths, with: .automatic)
            UIBlockingProgressHUD.dismiss()
        }
    }
    
    private func prepareSingleImageViewController(for vc: SingleImageViewController, with url: URL) {
        let imageView = UIImageView()
        imageView.kf.setImage(with: url) { [weak self] result in
            UIBlockingProgressHUD.dismiss()
            guard let self else {
                return
            }
            
            switch result {
            case .success(let cachedImage):
                vc.currentImage = cachedImage.image
            case .failure(let error):
                self.logger.insertLog(.loadSingleImageError(method: "ImagesListViewController.prepareSingleImageViewController", error: error))
                let alert = Alert.yesNoAlert(title: "Ошибка", message: "Не удалось загрузить изображение. Попробовать ещё раз?", style: .alert, completionYes: {
                    UIBlockingProgressHUD.show()
                    self.prepareSingleImageViewController(for: vc, with: url)
                }, completionNo: { vc.dismiss(animated: true, completion: nil) })
                vc.present(alert.controller, animated: true)
            }
        }
    }
}
