//
//  ExperienceTableViewCell.swift
//  MyCV
//
//  Created by Leming Deng on 2019-06-20.
//  Copyright © 2019 Leming Deng. All rights reserved.
//

import UIKit

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
                downloadTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
                    guard let data = data,
                        let image = UIImage(data: data) else { return }
                    DispatchQueue.main.async {
                        self.logo.image = image
                    }
                }
                downloadTask?.resume()
            }
        }
    }
    
    private var downloadTask: URLSessionDataTask?
    
    override func prepareForReuse() {
        downloadTask?.cancel()
        logo.image = nil
        super.prepareForReuse()
    }
}
