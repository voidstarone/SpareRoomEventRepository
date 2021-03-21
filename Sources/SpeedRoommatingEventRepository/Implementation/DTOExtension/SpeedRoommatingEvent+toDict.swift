//
//  File.swift
//  
//
//  Created by Thomas Lee on 19/03/2021.
//

import Foundation

extension ISpeedRoommatingEvent {
    
    public func toDict() -> [String:String] {
        let utcISODateFormatter = ISO8601DateFormatter()

        return ["cost": self.cost,
                "image_url": self.imageUrl,
                "location": self.location,
                "venue": self.venue,
                "start_time": utcISODateFormatter.string(from: self.startTime),
                "end_time": utcISODateFormatter.string(from: self.endTime)
        ]
    }
}
