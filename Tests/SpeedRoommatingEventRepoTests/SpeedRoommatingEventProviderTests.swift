import XCTest
@testable import SpeedRoommatingEventRepo

final class SpeedRoommatingRepoTests: XCTestCase {
    
    func testListAll() {
        let promiseToComplete = self.expectation(description: "fetch will complete")
        let ep = SpeedRoommatingEventProvider.default
        
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
        waitForExpectations(timeout: 1, handler: nil)

    }

    static var allTests = [
        ("testListAll", testListAll),
    ]
}
