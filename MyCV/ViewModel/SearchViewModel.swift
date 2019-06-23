//
//  SearchViewModel.swift
//  MyCV
//
//  Created by Leming Deng on 2019-06-22.
//  Copyright © 2019 Leming Deng. All rights reserved.
//

import Foundation

protocol SearchViewModel {
    var filters: Set<String> { get set}
    var candidates: [String] { get }
}
