//
//  UIApplication+Extensions.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 29.10.2025.
//

import UIKit

extension UIApplication {
    var keyWindow: UIWindow? {
       connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
    
    var windows: [UIWindow] {
       connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
    }
}
