//
//  ServiceProtocol.swift
//  MyCV
//
//  Created by Leming Deng on 2019-06-20.
//  Copyright © 2019 Leming Deng. All rights reserved.
//

import Foundation

protocol CVService {
    func getCV(success: @escaping (Resume) -> Void, fail: @escaping (Error) -> Void)
}

extension CVService {
    var decoder: JSONDecoder {
        let d = JSONDecoder()
        d.dateDecodingStrategy = .formatted(.yyyyMMdd)
        return d
    }
}

enum ServiceError: Error {
    case unknown
}
