//
//  File.swift
//  
//
//  Created by Thomas Lee on 19/03/2021.
//

import Foundation
import XCTest

@testable import SpeedRoommatingEventRepository


final class SpeedRoommatingEventRepoTests: XCTestCase {
    
    var ep: ISpeedRoommatingEventRepo!
    
    override func setUp() {
        ep = SpeedRoommatingEventRepo(eventFactory: MockSpeedRoommatingEventFactory(), eventSourceAdapter: MockEventSourceAdapterSuccessful())
    }
    
    func testInit() {
        XCTAssertNotNil(ep)
    }
    
    func testListAllEventsCompletes() {
        let promiseToComplete = self.expectation(description: "fetch will complete")
        
        ep.listAllEvents {
            result in
            switch result {
                case .failure:
                    break;
                case .success:
                    promiseToComplete.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testListAllEventsFailsGracefully() {
        let promiseToComplete = self.expectation(description: "fetch will fail due to bad data")
        
        ep = SpeedRoommatingEventRepo(eventFactory: MockSpeedRoommatingEventFactoryFails(), eventSourceAdapter: MockEventSourceAdapterFailure())
        
        ep.listAllEvents {
            result in
            switch result {
                case .failure:
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
                case let .failure:
                    break;
                case let .success(events):
                    XCTAssertGreaterThan(events.count, 0)
                    guard let event: ISpeedRoommatingEvent = events[0] else {
                        XCTAssert(false)
                        return
                    }
                    promiseToComplete.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testListAllEventReturnsResultsOrderedByStartTimeAscending() {
        let promiseToComplete = self.expectation(description: "sorted fetch will complete")
        
        ep.listAllEventsOrderedByStartTimeAscending {
            result in
            switch result {
                case .failure:
                    break;
                case let .success(events):
                    XCTAssertGreaterThan(events.count, 0)
                    
                    print("event comp")
                    print(events[0], events[1])
                    XCTAssertLessThan(events[0].startTime, events[1].startTime)
                    let event: ISpeedRoommatingEvent = events[0]
                    XCTAssertNotNil(event)
                    
                    promiseToComplete.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testListAllEventsByYearReturnsResults() {
        let promiseToComplete = self.expectation(description: "fetch will complete")
        
        ep.listAllEventsByYear {
            result in
            switch result {
                case .failure:
                    break;
                case let .success(eventsByYear):
                    XCTAssertGreaterThan(eventsByYear[2021]!.count, 0)
                    XCTAssertNil(eventsByYear[2020])
                    promiseToComplete.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testListAllEventsByYearThenMonthReturnsResults() {
        let promiseToComplete = self.expectation(description: "fetch will complete")
        
        ep.listAllEventsByYearThenMonth {
            result in
            switch result {
            case.failure:
                    break;
            case let .success(eventsByYear):
                let eventsIn2021 = eventsByYear[2021]!
                XCTAssertGreaterThan(eventsIn2021.count, 0)
                
                let eventsInJune = eventsIn2021[6]!
                XCTAssertGreaterThan(eventsInJune.count, 0)
                promiseToComplete.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
