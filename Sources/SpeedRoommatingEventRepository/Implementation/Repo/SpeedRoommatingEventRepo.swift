//
//  File.swift
//  
//
//  Created by Thomas Lee on 19/03/2021.
//

import Foundation

public enum SpeedRoommatingEventRepoError : Error {
    case network
    case unknown
}

public struct SpeedRoommatingEventRepo : ISpeedRoommatingEventRepo {
    
    private let eventSourceAdapter: ISpeedRoommatingEventSourceAdapter
    private let eventFactory: ISpeedRoommatingEventFactory = SpeedRoommatingEventFactory()
    
    public static let `default` = SpeedRoommatingEventRepo(eventSourceAdapter:
        SpeedRoommatingEventSourceJsonApiAdapter())
    
    public init(eventFactory: ISpeedRoommatingEventFactory, eventSourceAdapter: ISpeedRoommatingEventSourceAdapter) {
        self.eventSourceAdapter = eventSourceAdapter
    }
    
    public init(eventSourceAdapter: ISpeedRoommatingEventSourceAdapter) {
        self.eventSourceAdapter = eventSourceAdapter
    }
    
    private func produceEventRepoError(from inError: SpeedRoommatingEventSourceJsonApiAdapterError) -> SpeedRoommatingEventRepoError {
        switch inError {
        case .timeout:
            return .network
        default:
            return .unknown
        }
    }
    
    public func listAllEventsOrderedByStartTimeAscending(onComplete: @escaping (Result<[ISpeedRoommatingDTOEvent], Error>) -> Void) {
        
        listAllEvents {
            result in
            switch result {
            case let .failure(error as SpeedRoommatingEventSourceJsonApiAdapterError):
                onComplete(.failure(self.produceEventRepoError(from: error)))
                break
            case let .failure(error):
                onComplete(.failure(error))
                break
            case let .success(allEvents):
                let sortedEvents = allEvents.sorted { $0.startTime < $1.startTime }
                onComplete(.success(sortedEvents))
            }
        }
    }
    
    public func listAllEventsOnOrAfter(date: Date, onComplete: @escaping (Result<[ISpeedRoommatingDTOEvent], Error>) -> Void) {
        listAllEventsOrderedByStartTimeAscending {
            result in
            switch result {
            case let .failure(error as SpeedRoommatingEventSourceJsonApiAdapterError):
                onComplete(.failure(self.produceEventRepoError(from: error)))
                break
            case let .failure(error):
                onComplete(.failure(error))
                break
            case let .success(events):
                let eventsOnOrAfterDate = events.filter { $0.startTime >= date }
                onComplete(.success(eventsOnOrAfterDate))
            }
        }
    }
    
    public func listAllEventsBefore(date: Date, onComplete: @escaping (Result<[ISpeedRoommatingDTOEvent], Error>) -> Void) {
        listAllEventsOrderedByStartTimeAscending {
            result in
            switch result {
            case let .failure(error as SpeedRoommatingEventSourceJsonApiAdapterError):
                onComplete(.failure(self.produceEventRepoError(from: error)))
                break
            case let .failure(error):
                onComplete(.failure(error))
                break
            case let .success(events):
                let eventsOnOrAfterDate = events.filter { $0.startTime < date }
                onComplete(.success(eventsOnOrAfterDate))
            }
        }
    }
    
    public func listAllEvents(onComplete: @escaping (Result<[ISpeedRoommatingDTOEvent], Error>) -> Void) {
        eventSourceAdapter.listAllEventsAsDictionaries {
            result in
            
            switch result {
            case let .failure(error as SpeedRoommatingEventSourceJsonApiAdapterError):
                onComplete(.failure(self.produceEventRepoError(from: error)))
                break
            case let .failure(error):
                onComplete(.failure(error))
                break
            case let .success(dictEvents):
                var roommatingEvents: [ISpeedRoommatingDTOEvent] = []
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
