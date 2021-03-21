//
//  File.swift
//  
//
//  Created by Thomas Lee on 19/03/2021.
//

import Foundation
@testable import SpeedRoommatingEventRepository

struct MockSpeedRoommatingEvent : ISpeedRoommatingEvent {
    var imageUrl: String
    var cost: String
    var location: String
    var venue: String
    var startTime: Date
    var endTime: Date
}
