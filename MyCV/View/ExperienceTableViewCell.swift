//
//  ExperienceTableViewCell.swift
//  MyCV
//
//  Created by Leming Deng on 2019-06-20.
//  Copyright © 2019 Leming Deng. All rights reserved.
//

import UIKit
import Combine

class ExperienceTableViewCell: UITableViewCell {
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var company: UILabel! {
        didSet {
            company.text = nil
        }
    }
    @IBOutlet weak var period: UILabel! {
        didSet {
            period.text = nil
        }
    }
    @IBOutlet weak var title: UILabel! {
        didSet {
            title.text = nil
        }
    }
    
    var experience: Experience! {
        didSet {
            company.text = experience.company
            period.text = experience.period
            title.text = experience.title
            if let url = experience.logo {
                cancelable = URLSession.shared.dataTaskPublisher(for: url)
                    .compactMap { (data, _) in
                    UIImage(data: data)
                    }.replaceError(with: #imageLiteral(resourceName: "noImage"))
                    .receive(on: RunLoop.main).assign(to: \.image, on: self.logo)
            }
        }
    }
    
    private var cancelable: Cancellable?
    
    override func prepareForReuse() {
        cancelable?.cancel()
        logo.image = nil
        super.prepareForReuse()
    }
}
