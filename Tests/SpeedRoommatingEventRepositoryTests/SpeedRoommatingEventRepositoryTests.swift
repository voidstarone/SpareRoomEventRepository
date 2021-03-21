import XCTest
@testable import SpeedRoommatingEventRepository

final class SpeedRoommatingRepoTests: XCTestCase {
    
    func testListAll() {
        let promiseToComplete = self.expectation(description: "fetch will complete")
        let ep = SpeedRoommatingEventRepo.default
        
        ep.listAllEvents {
            result in
            
            switch result {
            case .failure:
                break
            case let .success(events):
                if events.count > 0 {
                    promiseToComplete.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testListAllOrderedAscending() {
        let promiseToComplete = self.expectation(description: "ordered fetch will complete")
        let ep = SpeedRoommatingEventRepo.default
        
        ep.listAllEventsOrderedByStartTimeAscending {
            result in
            
            switch result {
            case .failure:
                break
            case let .success(events):
                XCTAssertLessThanOrEqual(events[0].startTime, events[1].startTime)
                promiseToComplete.fulfill()
            }
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testListAllByYear() {
        let promiseToComplete = self.expectation(description: "grouped fetch will complete")
        let ep = SpeedRoommatingEventRepo.default
        
        ep.listAllEventsByYear {
            result in
            
            switch result {
            case .failure:
                break
            case let .success(years):
                
                XCTAssertNotNil(years[2021])
                XCTAssertNotNil(years[2020])
                XCTAssertNil(years[2019])
                promiseToComplete.fulfill()
            }
        }
        waitForExpectations(timeout: 2, handler: nil)
    }

    static var allTests = [
        ("testListAll", testListAll),
    ]
}
