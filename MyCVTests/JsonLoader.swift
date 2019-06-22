//
//  JsonLoader.swift
//  MyCVTests
//
//  Created by Leming Deng on 2019-06-21.
//  Copyright © 2019 Leming Deng. All rights reserved.
//

import Foundation

enum JsonLoader: String {
    case cv
    
    var toData: Data {
        let url = Bundle(for: Dummy.self).url(forResource: rawValue, withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    private final class Dummy {}
}

