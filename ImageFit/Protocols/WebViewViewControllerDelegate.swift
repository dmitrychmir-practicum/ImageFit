//
//  WebViewViewControllerDelegate.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 23.10.2025.
//

protocol WebViewViewControllerDelegate: AnyObject {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String)
    func webViewViewControllerDidCancel(_ vc: WebViewViewController)
}
