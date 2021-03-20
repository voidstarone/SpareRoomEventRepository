//
//  File.swift
//  
//
//  Created by Thomas Lee on 19/03/2021.
//

import Foundation

public enum EventProviderError : Error {
    case noConnection
}

public struct SpeedRoommatingEventProvider : ISpeedRoommatingEventProvider {
    
    private let eventSourceAdapter: ISpeedRoommatingEventSourceAdapter
    private let eventFactory: ISpeedRoommatingEventFactory = SpeedRoommatingEventFactory()
    
    static let `default` = SpeedRoommatingEventProvider(eventSourceAdapter:
        SpeedRoommatingEventSourceJsonApiAdapter())
    
    public init(eventFactory: ISpeedRoommatingEventFactory, eventSourceAdapter: ISpeedRoommatingEventSourceAdapter) {
        self.eventSourceAdapter = eventSourceAdapter
    }
    
    public init(eventSourceAdapter: ISpeedRoommatingEventSourceAdapter) {
        self.eventSourceAdapter = eventSourceAdapter
    }
    
    public func listAllEvents(onComplete: @escaping (Result<[ISpeedRoommatingEvent], Error>) -> Void) {
        eventSourceAdapter.listAllEventsAsDictionaries {
            result in
            
            switch result {
            case let .failure(error):
                onComplete(.failure(error))
                break
            case let .success(dictEvents):
                var roommatingEvents: [ISpeedRoommatingEvent] = []
                for dictEvent in dictEvents {
                    guard let roommatingEvent = self.eventFactory.createRoommatingEvent(fromDict: dictEvent) else {
                        continue
                    }
                    roommatingEvents.append(roommatingEvent)
                }
                onComplete(.success(roommatingEvents))
            }
        }
    }

}
