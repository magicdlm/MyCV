//
//  ProfileViewController.swift
//  MyCV
//
//  Created by Leming Deng on 2019-06-20.
//  Copyright © 2019 Leming Deng. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneText: UITextView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailText: UITextView!
    
    var model: Profile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    private func updateView() {
        if let profile = model {
            phoneLabel?.text = "Phone:".localizedCapitalized
            emailLabel?.text = "Email:".localizedCapitalized
            
            nameLabel?.text = profile.name
            phoneText?.text = profile.phone
            emailText?.text = profile.email
        }
    }
}
