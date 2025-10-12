//
//  SingleImageViewController+Extensions.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 10.10.2025.
//

import UIKit

extension SingleImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        setCenter()
    }
}
