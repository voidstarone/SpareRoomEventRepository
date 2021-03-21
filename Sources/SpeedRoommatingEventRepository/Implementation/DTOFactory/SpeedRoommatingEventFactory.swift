//
//  File.swift
//  
//
//  Created by Thomas Lee on 19/03/2021.
//

import Foundation

public struct SpeedRoommatingEventFactory : ISpeedRoommatingEventFactory {
    public func createRoommatingEvent(imageUrl: String, cost: String, location: String, venue: String, startTime: Date, endTime: Date) -> ISpeedRoommatingDTOEvent {
        return SpeedRoommatingEvent(imageUrl: imageUrl,
                                    cost: cost,
                                    location:location,
                                    venue: venue,
                                    startTime: startTime,
                                    endTime: endTime)
    }
    
    public func createRoommatingEvent(fromDict eventDict:[String:String]) -> ISpeedRoommatingDTOEvent? {
        guard let cost = eventDict["cost"] else {
            return nil
        }
        guard let imageUrl = eventDict["image_url"] else {
            return nil
        }
        guard let location = eventDict["location"] else {
            return nil
        }
        guard let venue = eventDict["venue"] else {
            return nil
        }
        
        let utcISODateFormatter = ISO8601DateFormatter()
        guard let startTime8601 = eventDict["start_time"] else {
            return nil
        }
        let startTime = utcISODateFormatter.date(from: startTime8601)
        guard let endTime8601 = eventDict["end_time"] else {
            return nil
        }
        let endTime = utcISODateFormatter.date(from: endTime8601)
        
        if (startTime == nil || endTime == nil) {
            return nil
        }
        
        if (imageUrl == "" || cost == "" || location == "" || venue == "") {
            return nil
        }
        return createRoommatingEvent(imageUrl: imageUrl, cost: cost, location: location, venue: venue, startTime: startTime!, endTime: endTime!)
    }
}
