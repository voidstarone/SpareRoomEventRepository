//
//  File.swift
//
//
//  Created by Thomas Lee on 19/03/2021.
//

import Foundation
@testable import SpeedRoommatingEventRepository

struct MockSpeedRoommatingEventSourceAdapterArbitrary : ISpeedRoommatingEventSourceAdapter {
    
    // This is a bit evil. But it's a very basic thing, and it's a fairly quick - only slightly evil - option
    var eventFactory: ISpeedRoommatingEventFactory = SpeedRoommatingEventFactory()
    
    var eventsToSupply: [ISpeedRoommatingEvent]

    func listAllEventsAsDictionaries(onComplete: @escaping (Result<[[String:String]], Error>) -> Void) {
        
        var eventsToReturn: [[String:String]] = [];
        eventsToSupply.forEach {
            eventsToReturn.append($0.toDict())
        }
        
        onComplete(.success(eventsToReturn))
    }
}
