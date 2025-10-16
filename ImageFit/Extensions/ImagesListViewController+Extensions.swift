//
//  ImagesListViewController+Extensions.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 05.10.2025.
//

import UIKit

extension ImagesListViewController:  UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosName.count
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

extension ImagesListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifier, sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let image = UIImage(named: photosName[indexPath.row]) else {
            return 0
        }
        
        let insets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let width = tableView.bounds.width - insets.left - insets.right
        let scale = width / image.size.width
        let height = image.size.height * scale + image.capInsets.top + image.capInsets.bottom
        
        return height
    }
}
