//
//  File.swift
//
//
//  Created by Thomas Lee on 19/03/2021.
//

import Foundation
import XCTest

@testable import SpeedRoommatingEventRepo


final class SpeedRoommatingEventSourceJsonFileAdapterTests: XCTestCase {
    
    var esa: ISpeedRoommatingEventSourceAdapter!
    
    override func setUp() {
        
        //This is horrifying, but because I'm not on swift-tools 5.3, I'm not sure what other choice I have other than to leave it untested.
        // I have included settings which _should_ work in package.swift, as well as the commented out jsonUrl below, so hopefully you will be able to use those rather than this nightmare.
        let jsonUrl = URL(string: "./Developer/SpareRoom/SpeedRoommatingEventRepo/Tests/SpeedRoommatingEventRepoTests/Tests/Resources/event_test.json", relativeTo: FileManager.default.homeDirectoryForCurrentUser)
        // Please use this one, as well as changing swift-tools to 5.3 and uncommenting the resources bit in the test target
        //let jsonUrl = Bundle.module.url(forResource: "event_test", withExtension: "json")
        
        esa = SpeedRoommatingEventSourceJsonFileAdapter(config: SpeedRoommatingEventSourceJsonFileAdapterConfig(fileUrl: jsonUrl!))
    }
    
    override func tearDown() {
        esa = nil
    }
    
    func testInit() {
 
        XCTAssertNotNil(esa)
    }
    
    func testListAllEventsCompletes() {
        let promiseToComplete = self.expectation(description: "fetch will complete")

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
