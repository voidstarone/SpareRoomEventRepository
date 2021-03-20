//
//  File.swift
//  
//
//  Created by Thomas Lee on 20/03/2021.
//

import Foundation

import Foundation
@testable import SpeedRoommatingEventRepo

public struct MockSpeedRoommatingEventFactoryFails : ISpeedRoommatingEventFactory {
    
    public func createRoommatingEvent(fromDict eventDict: [String : String]) -> ISpeedRoommatingEvent? {
        return nil
    }
    
    public func createRoommatingEvent(imageUrl: String, cost: String, location: String, venue: String, startTime: Date, endTime: Date) -> ISpeedRoommatingEvent {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return MockSpeedRoommatingEvent(imageUrl: "http://example.com/jpg2",
                               cost: "Free",
                               location: "Leicester",
                               venue: "Firebug",
                               startTime: formatter.date(from: "2021-06-01 21:00")!,
                               endTime: formatter.date(from: "2021-06-02 04:00")!)
    }
}
