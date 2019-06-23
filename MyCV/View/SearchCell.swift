//
//  SearchCell.swift
//  MyCV
//
//  Created by Leming Deng on 2019-06-22.
//  Copyright © 2019 Leming Deng. All rights reserved.
//

import UIKit

final class SearchCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    
    override var isSelected: Bool {
        didSet {
            title.textColor = isSelected ? .black : .gray
            layer.borderColor = title.textColor.cgColor
        }
    }
}
