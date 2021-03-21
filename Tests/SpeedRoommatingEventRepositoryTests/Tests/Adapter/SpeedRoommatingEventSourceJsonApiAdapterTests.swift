//
//  File.swift
//
//
//  Created by Thomas Lee on 19/03/2021.
//

import Foundation
import XCTest

@testable import SpeedRoommatingEventRepository


final class SpeedRoommatingEventSourceJsonApiAdapterTests: XCTestCase {
    
    var esa: ISpeedRoommatingEventSourceAdapter!
    
    func testInit() {
        esa = SpeedRoommatingEventSourceJsonApiAdapter()
        XCTAssertNotNil(esa)
    }
    
    func testListAllEventsCompletes() {
        let promiseToComplete = self.expectation(description: "fetch will complete")

        esa = SpeedRoommatingEventSourceJsonApiAdapter()
        esa.listAllEventsAsDictionaries {
            result in
            switch result {
                case .failure:
                    break;
                case .success:
                    promiseToComplete.fulfill()
            }
        }
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testListAllEventReturnsResults() {
       let promiseToComplete = self.expectation(description: "fetch will complete")

        esa = SpeedRoommatingEventSourceJsonApiAdapter()
        esa.listAllEventsAsDictionaries {
            result in
            switch result {
                case .failure:
                    break;
                case .success:
                    promiseToComplete.fulfill()
            }
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testListAllEventReturnsNoEmptyResults() {
       let promiseToComplete = self.expectation(description: "fetch will complete")

        esa = SpeedRoommatingEventSourceJsonApiAdapter()
        esa.listAllEventsAsDictionaries {
            result in
            switch result {
                case .failure(_):
                    break;
                case let .success(dictItems):
                    for dictItem in dictItems {
                        if dictItem.isEmpty {
                            // Please no assert spam
                            XCTAssertFalse(dictItem.isEmpty)
                        }
                    }
                    promiseToComplete.fulfill()
            }
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
}
