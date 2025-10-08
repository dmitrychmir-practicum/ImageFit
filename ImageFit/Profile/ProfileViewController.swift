//
//  ProfileViewController.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 06.10.2025.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    @IBOutlet
    weak var avatarImage: UIImageView!
    @IBOutlet
    weak var exitButton: UIButton!
    @IBOutlet
    weak var fioLabel: UILabel!
    @IBOutlet
    weak var userName: UILabel!
    @IBOutlet
    weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction
    func exitButtonTap(_ sender: UIButton) {
    }
}
