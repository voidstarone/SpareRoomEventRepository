import Foundation

public protocol ISpeedRoommatingEventRepo {
    
    init(eventSourceAdapter: ISpeedRoommatingEventSourceAdapter)
    init(eventFactory: ISpeedRoommatingEventFactory, eventSourceAdapter: ISpeedRoommatingEventSourceAdapter)
    
    func listAllEvents(onComplete: @escaping (Result<[ISpeedRoommatingDTOEvent], Error>) -> Void)
    func listAllEventsOrderedByStartTimeAscending(onComplete: @escaping (Result<[ISpeedRoommatingDTOEvent], Error>) -> Void)
    func listAllEventsOnOrAfter(date: Date, onComplete: @escaping (Result<[ISpeedRoommatingDTOEvent], Error>) -> Void)
    func listAllEventsByYear(onComplete: @escaping (Result<[Int:[ISpeedRoommatingDTOEvent]], Error>) -> Void)
    func listAllEventsByYearThenMonth(onComplete: @escaping (Result<[Int:[Int:[ISpeedRoommatingDTOEvent]]], Error>) -> Void)
}
