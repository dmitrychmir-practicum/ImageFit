//
//  UIBlockingProgressHUD.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 01.11.2025.
//

import UIKit
import ProgressHUD

final class UIBlockingProgressHUD: NSObject {
    private static var window: UIWindow? {
        return UIApplication.shared.windows.first
    }
    
    static func show() {
        guard let window else { return }
        window.isUserInteractionEnabled = false
        ProgressHUD.animate()
    }
    
    static func dismiss() {
        guard let window else { return }
        window.isUserInteractionEnabled = true
        ProgressHUD.dismiss()
    }
}
