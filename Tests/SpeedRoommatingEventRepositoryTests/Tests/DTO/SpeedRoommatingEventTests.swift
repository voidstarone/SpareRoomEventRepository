import XCTest
@testable import SpeedRoommatingEventRepository

final class SpeedRoommatingEventTests: XCTestCase {
    
    func testInstatiateEvent() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let event: ISpeedRoommatingEvent = SpeedRoommatingEvent(imageUrl: "url",
                                                                cost: "cost",
                                                                location: "location",
                                                                venue: "venue",
                                                                startTime: formatter.date(from: "2021-03-20 10:00")!,
                                                                endTime: formatter.date(from: "2021-03-20 15:08")!
        )
        XCTAssertEqual(event.imageUrl, "url")
        XCTAssertEqual(event.cost, "cost")
        XCTAssertEqual(event.location, "location")
        XCTAssertEqual(event.venue, "venue")
        XCTAssertEqual(event.startTime, formatter.date(from: "2021-03-20 10:00")!)
        XCTAssertEqual(event.endTime, formatter.date(from: "2021-03-20 15:08")!)
    }
    
}
