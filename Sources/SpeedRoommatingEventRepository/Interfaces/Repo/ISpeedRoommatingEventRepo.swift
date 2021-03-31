import Foundation

public protocol ISpeedRoommatingEventRepo {
    
    init(eventSourceAdapter: ISpeedRoommatingEventSourceAdapter)
    init(eventFactory: ISpeedRoommatingEventFactory, eventSourceAdapter: ISpeedRoommatingEventSourceAdapter)
    
    func listAllEvents(onComplete: @escaping (Result<[ISpeedRoommatingDTOEvent], Error>) -> Void)
    func listAllEventsOrderedByStartTimeAscending(onComplete: @escaping (Result<[ISpeedRoommatingDTOEvent], Error>) -> Void)
    func listAllEventsOnOrAfter(date: Date, onComplete: @escaping (Result<[ISpeedRoommatingDTOEvent], Error>) -> Void)
    func listAllEventsBefore(date: Date, onComplete: @escaping (Result<[ISpeedRoommatingDTOEvent], Error>) -> Void)
}
