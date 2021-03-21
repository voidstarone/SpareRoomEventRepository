//
//  File.swift
//  
//
//  Created by Thomas Lee on 19/03/2021.
//

import Foundation

extension ISpeedRoommatingEvent {
    
    // Unused, was going to be for caching, but I decided to focus on other stuff.
    // Commented out so you can see it, but it doesn't screw up the coverage stats
//    public func toDict() -> [String:String] {
//        let utcISODateFormatter = ISO8601DateFormatter()
//
//        return ["cost": self.cost,
//                "image_url": self.imageUrl,
//                "location": self.location,
//                "venue": self.venue,
//                "start_time": utcISODateFormatter.string(from: self.startTime),
//                "end_time": utcISODateFormatter.string(from: self.endTime)
//        ]
//    }
}
