//
//  SingleImageViewController.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 08.10.2025.
//

import UIKit

final class SingleImageViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet private var scrollView: UIScrollView!
    
    var currentImage: UIImage? {
        didSet {
            guard isViewLoaded, let currentImage else { return }
            imageView.image = currentImage
            imageView.frame.size = currentImage.size
            rescaleAndCenterImageInScrollView(image: currentImage)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 1.25
        
        guard let currentImage else { return }
        imageView.image = currentImage
        imageView.frame.size = currentImage.size
        rescaleAndCenterImageInScrollView(image: currentImage)
    }
    
    func setCenter(){
        let hInset = max((scrollView.bounds.size.width - imageView.frame.size.width)/2, 0)
        let vInset = max((scrollView.bounds.size.height - imageView.frame.size.height)/2, 0)
        
        scrollView.contentInset = UIEdgeInsets(top: vInset, left: hInset, bottom: vInset, right: hInset)
    }
    
    func rescaleAndCenterImageInScrollView(image: UIImage) {
        let minZoomScale = scrollView.minimumZoomScale
        let maxZoomScale = scrollView.maximumZoomScale
        view.layoutIfNeeded()
        let visibleRectSize = scrollView.bounds.size
        let imageSize = image.size
        let hScale = visibleRectSize.width / imageSize.width
        let vScale = visibleRectSize.height / imageSize.height
        let scale = min(maxZoomScale, max(minZoomScale, min(hScale, vScale)))
        scrollView.setZoomScale(scale, animated: false)
        scrollView.layoutIfNeeded()
    }
    
    @IBAction
    private func didTapBackButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction
    private func didTapShareButton(_ sender: UIButton) {
        guard let currentImage else { return }
        let activityViewController = UIActivityViewController(activityItems: [currentImage], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
}
