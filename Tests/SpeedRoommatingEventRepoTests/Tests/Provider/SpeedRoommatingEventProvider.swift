//
//  File.swift
//  
//
//  Created by Thomas Lee on 19/03/2021.
//

import Foundation
import XCTest

@testable import SpeedRoommatingEventRepo


final class SpeedRoommatingEventProviderTests: XCTestCase {
    
    var ep: ISpeedRoommatingEventProvider!
    
    override func setUp() {
        ep = SpeedRoommatingEventProvider(eventFactory: MockSpeedRoommatingEventFactory(), eventSourceAdapter: MockEventSourceAdapterSuccessful())
    }
    
    func testInit() {
        XCTAssertNotNil(ep)
    }
    
    func testListAllEventsCompletes() {
        let promiseToComplete = self.expectation(description: "fetch will complete")
        
        ep.listAllEvents {
            result in
            switch result {
                case .failure(_):
                    break;
                case .success(_):
                    promiseToComplete.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testListAllEventsFailsGracefully() {
        let promiseToComplete = self.expectation(description: "fetch will fail due to bad data")
        
        ep = SpeedRoommatingEventProvider(eventFactory: MockSpeedRoommatingEventFactoryFails(), eventSourceAdapter: MockEventSourceAdapterFailure())
        
        ep.listAllEvents {
            result in
            switch result {
                case .failure(_):
                    promiseToComplete.fulfill()
                default:
                    break
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testListAllEventReturnsResults() {
        let promiseToComplete = self.expectation(description: "fetch will complete")
        
        ep.listAllEvents {
            result in
            switch result {
                case let .failure(_):
                    break;
                case let .success(events):
                    print(events)
                    XCTAssertGreaterThan(events.count, 0)
                    promiseToComplete.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
