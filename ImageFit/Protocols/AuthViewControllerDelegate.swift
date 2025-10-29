//
//  AuthViewControllerDelegate.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 27.10.2025.
//

protocol AuthViewControllerDelegate: AnyObject {
    func didAuthenticate(_ viewController: AuthViewController)
}
