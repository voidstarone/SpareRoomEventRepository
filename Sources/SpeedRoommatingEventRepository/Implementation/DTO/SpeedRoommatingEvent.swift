//
//  SpeedRoommatingEvent.swift
//  
//
//  Created by Thomas Lee on 18/03/2021.
//

import Foundation

public struct SpeedRoommatingEvent : ISpeedRoommatingDTOEvent {
    public var imageUrl: String
    public var cost: String // Probably should be enum, but I don't have enough information to make a really good choice.
    public var location: String
    public var venue: String
    public var startTime: Date
    public var endTime: Date
}

