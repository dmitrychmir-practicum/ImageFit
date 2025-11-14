//
//  ImagesListCell.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 05.10.2025.
//

import UIKit
import Kingfisher

final class ImagesListCell: UITableViewCell {
    
    static let reuseIdentifier = "ImagesListCell"
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var effectView: UIVisualEffectView!
    
    weak var delegate: ImagesListCellDelegate?
    
    func configCell(_ url: URL, date: Date?, isLiked: Bool) {
        downloadImage(url)
        setDateLabel(date)
        setLikeButtonImage(isLiked)
    }

    private func downloadImage(_ thumbUrl: URL) {
        cellImage.kf.indicatorType = .activity
        cellImage.kf.setImage(with: thumbUrl, placeholder: UIImage(resource: .imageStub)) { [weak self] _ in
            guard let self else { return }
            self.cellImage.layer.cornerRadius = 16
            self.cellImage.layer.masksToBounds = true
        }
    }
    
    private func setDateLabel(_ date: Date?) {
        dateLabel.text = date?.dateTimeString ?? ""
    }
    
    func setLikeButtonImage(_ isLiked: Bool) {
        likeButton.setImage(UIImage(resource: isLiked ? .active : .noActive), for: .normal)
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        delegate?.didTapLike(self)
    }
}
