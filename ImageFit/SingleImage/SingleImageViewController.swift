//
//  SingleImageViewController.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 08.10.2025.
//

import UIKit

final class SingleImageViewController: UIViewController {
    
    @IBOutlet private var imageView: UIImageView!
    
    var currentImage: UIImage? {
        didSet {
            guard isViewLoaded else { return }
            imageView.image = currentImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = currentImage
    }
    
    @IBAction
    private func didTapBackButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
