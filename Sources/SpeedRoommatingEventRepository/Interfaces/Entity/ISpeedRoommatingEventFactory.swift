//
//  File.swift
//  
//
//  Created by Thomas Lee on 19/03/2021.
//

import Foundation

public protocol ISpeedRoommatingEventFactory {
    func createRoommatingEvent(imageUrl: String, cost: String, location: String, venue: String, startTime: Date, endTime: Date) -> ISpeedRoommatingDTOEvent
    func createRoommatingEvent(fromDict eventDict:[String:String]) -> ISpeedRoommatingDTOEvent?

}
