//
//  ViewController.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 04.10.2025.
//

import UIKit

final class ImagesListViewController: UIViewController {

    @IBOutlet
    private var tableWiew: UITableView!
    let segueIdentifier: String = "ShowSingleImage"
    
    let photosName: [String] = Array(0..<20).map{ "\($0)" }
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableWiew.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
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
            
            let image = UIImage(named: photosName[indexPath.row])
            viewController.currentImage = image
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }

    func configCell(for cell: ImagesListCell, with indexPath: IndexPath){
        guard let image = UIImage(named: photosName[indexPath.row]) else { return }
        cell.dataLabel.text = dateFormatter.string(from: Date())
        cell.cellImage.image = image
        cell.cellImage.layer.cornerRadius = 16
        cell.cellImage.layer.masksToBounds = true
        let isActive = indexPath.row % 2 == 0
        let likeImage = isActive ? UIImage(named: "Active") : UIImage(named: "NoActive")
        cell.likeButton.setImage(likeImage, for: .normal)
        roundingSubstrateCorners(cell)
    }
    
    private func roundingSubstrateCorners(_ cell: ImagesListCell) {
        let corners = UIRectCorner(arrayLiteral: [.bottomLeft, .bottomRight])
        let maskPath = UIBezierPath(roundedRect: cell.effectView.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 16, height: 16))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = cell.effectView.bounds
        maskLayer.path = maskPath.cgPath
        cell.effectView.layer.mask = maskLayer
        
    }
}
