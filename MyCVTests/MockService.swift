//
//  MockService.swift
//  MyCVTests
//
//  Created by Leming Deng on 2019-06-21.
//  Copyright © 2019 Leming Deng. All rights reserved.
//

import Foundation
@testable import MyCV

final class MockService: CVService {
    var shouldFail = false
    func getCV(success: @escaping (Resume) -> Void, fail: @escaping (Error) -> Void) {
        if shouldFail {
            fail(ServiceError.unknown)
        } else {
            success(try! decoder.decode(Resume.self, from: JsonLoader.cv.toData))
        }
    }
}
