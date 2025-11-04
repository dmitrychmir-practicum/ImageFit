//
//  ProfileViewController.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 06.10.2025.
//

import UIKit
import Kingfisher

final class ProfileViewController: UIViewController {
    
    private var avatarImage: UIImage?
    private var avatarImageView: UIImageView!
    private var fullNameLabel: UILabel!
    private var accountLabel: UILabel!
    private var helloWorldLabel: UILabel!
    private var logoutButton: UIButton!
    private var profileImageServiceObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let profileDetails = ProfileService.shared.profile
        initAvatarImage(withName: "no_avatar")
        initLogoutButton()
        initFullName(withFullName: profileDetails?.fullName)
        initAccountName(withAccount: profileDetails?.loginName)
        initHelloWorld(withBio: profileDetails?.bio)
        
        profileImageServiceObserver = NotificationCenter.default.addObserver(forName: ProfileImageService.didChangeNotification, object: nil, queue: .main) { [weak self] _ in
            guard let self else { return }
            self.updateAvatar()
        }
        updateAvatar()
    }
    
    private func updateAvatar() {
        guard let profileImageUrl = ProfileImageService.shared.avatarURL, let url = URL(string: profileImageUrl) else { return }
        let processor = RoundCornerImageProcessor(cornerRadius: 50)
        
        avatarImageView.kf.setImage(with: url, placeholder: avatarImage, options: [.processor(processor)])
    }
    
    private func initAvatarImage(withName imageName: String) {
        avatarImage = UIImage(named: imageName)
        avatarImageView = UIImageView(image: avatarImage)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(avatarImageView)
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            avatarImageView.widthAnchor.constraint(equalToConstant: 70),
            avatarImageView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func initLogoutButton() {
        logoutButton = UIButton(type: .custom)
        if let image = UIImage(named: "Exit") {
            logoutButton.setImage(image, for: .normal)
        } else {
        let logoutImage = UIImage(systemName: "ipad.and.arrow.forward")?.withTintColor(.ypRed, renderingMode: .alwaysOriginal)
            let logoutImageView = UIImageView(image: logoutImage)
            logoutImageView.translatesAutoresizingMaskIntoConstraints = false
            logoutButton.addSubview(logoutImageView)
            NSLayoutConstraint.activate([
                logoutImageView.widthAnchor.constraint(equalToConstant: 20),
                logoutImageView.heightAnchor.constraint(equalToConstant: 22),
                logoutImageView.topAnchor.constraint(equalTo: logoutButton.topAnchor, constant: 11),
                logoutImageView.leadingAnchor.constraint(equalTo: logoutButton.leadingAnchor, constant: 16)
            ])
        }
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
        NSLayoutConstraint.activate([
            logoutButton.trailingAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45),
            logoutButton.widthAnchor.constraint(equalToConstant: 44),
            logoutButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        logoutButton.addTarget(self, action: #selector(didTapLogoutButton), for: .touchUpInside)
    }
    
    private func initFullName(withFullName fullName: String?) {
        fullNameLabel = UILabel()
        
        if let fullName {
            fullNameLabel.text = fullName
        } else {
            fullNameLabel.text = "Unknown"
        }
        
        fullNameLabel.textColor = .white
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fullNameLabel)
        
        NSLayoutConstraint.activate([
            fullNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            fullNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        
        fullNameLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
    }
    
    private func initAccountName(withAccount account: String?) {
        accountLabel = UILabel()
        
        if let account {
            accountLabel.text = account
        } else {
            accountLabel.text = "@unknown"
        }
        
        accountLabel.textColor = .ypGray
        accountLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(accountLabel)
        
        NSLayoutConstraint.activate([
            accountLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor, constant: 0),
            accountLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 8),
            accountLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        accountLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    }

    private func initHelloWorld(withBio description: String?) {
        helloWorldLabel = UILabel()
        helloWorldLabel.text = description ?? "Hello, world!"
        
        helloWorldLabel.textColor = .white
        helloWorldLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(helloWorldLabel)
        
        NSLayoutConstraint.activate([
            helloWorldLabel.leadingAnchor.constraint(equalTo: accountLabel.leadingAnchor, constant: 0),
            helloWorldLabel.topAnchor.constraint(equalTo: accountLabel.bottomAnchor, constant: 8),
            helloWorldLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        helloWorldLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    }
    
    @objc
    private func didTapLogoutButton() {
        
    }
}
