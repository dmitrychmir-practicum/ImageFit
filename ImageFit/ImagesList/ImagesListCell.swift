//
//  ImagesListCell.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 05.10.2025.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    
    static let reuseIdentifier = "ImagesListCell"
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var dataLabel: UILabel!
    @IBOutlet var effectView: UIVisualEffectView!
}
