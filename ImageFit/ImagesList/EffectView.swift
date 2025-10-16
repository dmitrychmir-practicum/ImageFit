//
//  EffectView.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 15.10.2025.
//

import UIKit

final class EffectView: UIVisualEffectView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let corners = UIRectCorner(arrayLiteral: [.bottomLeft, .bottomRight])
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 16, height: 16))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        maskLayer.layoutIfNeeded()
        self.layer.mask = maskLayer
    }
}
