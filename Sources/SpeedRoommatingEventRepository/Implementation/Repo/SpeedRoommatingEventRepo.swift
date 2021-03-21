//
//  File.swift
//  
//
//  Created by Thomas Lee on 19/03/2021.
//

import Foundation

public enum EventRepoError : Error {
    case noConnection
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
    
    public func listAllEventsOrderedByStartTimeAscending(onComplete: @escaping (Result<[ISpeedRoommatingEvent], Error>) -> Void) {
        
        listAllEvents {
            result in
            switch result {
            case let .failure(error):
                onComplete(.failure(error))
                break
            case let .success(allEvents):
                let sortedEvents = allEvents.sorted { $0.startTime < $1.startTime }
                onComplete(.success(sortedEvents))
            }
        }
    }
    
    public func listAllEventsOnOrAfter(date: Date, onComplete: @escaping (Result<[ISpeedRoommatingEvent], Error>) -> Void) {
        listAllEventsOrderedByStartTimeAscending {
            result in
            switch result {
            case let .failure(error):
                onComplete(.failure(error))
                break
            case let .success(events):
                let eventsOnOrAfterDate = events.filter { $0.startTime >= date }
                onComplete(.success(eventsOnOrAfterDate))
            }
        }
    }
    
    
    public func listAllEventsByYear(onComplete: @escaping (Result<[Int : [ISpeedRoommatingEvent]], Error>) -> Void) {
        
        listAllEventsOrderedByStartTimeAscending {
            result in
            switch result {
            case let .failure(error):
                onComplete(.failure(error))
                break
            case let .success(allEvents):
                var yearDict: [Int: [ISpeedRoommatingEvent]] = [:]
                allEvents.forEach {
                    event in
                    let thisYear = Calendar.current.dateComponents([.year], from: event.startTime).year!
                    if yearDict[thisYear] == nil {
                        yearDict[thisYear] = []
                    }
                    yearDict[thisYear]!.append(event)
                }
                onComplete(.success(yearDict))
            }
        }
    }
    
    public func listAllEventsByYearThenMonth(onComplete: @escaping (Result<[Int : [Int : [ISpeedRoommatingEvent]]], Error>) -> Void) {
        listAllEventsByYear {
            result in
            switch result {
            case let .failure(error):
                onComplete(.failure(error))
                break
            case let .success(allYearDicts):
                var newYearsDicts: [Int : [Int : [ISpeedRoommatingEvent]]] = [:]
                allYearDicts.forEach {
                    yearDict in
                    let eventsThisYear = yearDict.value
                    let thisYear = yearDict.key
                    var newYearDicts: [Int: [ISpeedRoommatingEvent]] = [:]
                    eventsThisYear.forEach {
                        event in
                        let thisMonth = Calendar.current.dateComponents([.month], from: event.startTime).month!
                        if newYearDicts[thisMonth] == nil {
                            newYearDicts[thisMonth] = []
                        }
                        newYearDicts[thisMonth]?.append(event)
                    }
                    newYearsDicts[thisYear] = newYearDicts
                }
                onComplete(.success(newYearsDicts))
                
            }
        }
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
