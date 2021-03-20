//
//  File.swift
//  
//
//  Created by Thomas Lee on 18/03/2021.
//

import Foundation

public protocol ISpeedRoommatingEvent {
    var imageUrl: String {get}
    var cost: String {get}
    var location: String {get}
    var venue: String {get}
    var startTime: Date {get}
    var endTime: Date {get}
}


