//
//  MasterViewModelTests.swift
//  MyCVTests
//
//  Created by Leming Deng on 2019-06-21.
//  Copyright © 2019 Leming Deng. All rights reserved.
//

import XCTest
@testable import MyCV

class MasterViewModelTests: XCTestCase {
    
    let service = MockService()
    var viewModel: MasterViewModel!

    override func setUp() {
        viewModel = MasterViewModel(service: service)
    }

    func testThatItSuccessfullyFetchData() {
        service.shouldFail = false
        viewModel.fetchData(success: { _ in }) { (_) in
            XCTFail("should not fail")
        }
    }
    
    func testThatItDisplayCorrectSections() {
        service.shouldFail = false
        viewModel.fetchData(success: { _ in
            XCTAssertEqual(self.viewModel.sections.count, 2)
            guard case MasterViewModel.Section.summary(_) = self.viewModel.sections[0] else {
                XCTFail("Section 1 should be summary")
                return
            }
            guard case MasterViewModel.Section.experience(_) = self.viewModel.sections[1] else {
                XCTFail("Section 2 should be experience")
                return
            }
            
        }, fail: { (_) in})
    }
    
    func testThatItCanFilterSwiftExperience() {
        service.shouldFail = false
        viewModel.fetchData(success: { _ in}, fail: { (_) in})
        viewModel.filters = ["Swift"]
        XCTAssertEqual(viewModel.sections[1].itemNumber, 3)
    }

}
