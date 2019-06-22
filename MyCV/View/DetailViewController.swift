//
//  DetailViewController.swift
//  MyCV
//
//  Created by Leming Deng on 2019-06-20.
//  Copyright © 2019 Leming Deng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var period: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var keys: UILabel!
    @IBOutlet weak var detail: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        logo.image = image
        period.text = detailItem?.period
        titleLabel.text = detailItem?.title
        detail.text = detailItem?.detail
        keys.text = detailItem?.keys.joined(separator: ", ")
    }

    var detailItem: Experience?
    var image: UIImage?

}

