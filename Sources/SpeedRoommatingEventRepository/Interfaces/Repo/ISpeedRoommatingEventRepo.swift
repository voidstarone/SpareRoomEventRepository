import Foundation

public protocol ISpeedRoommatingEventRepo {
    
    init(eventSourceAdapter: ISpeedRoommatingEventSourceAdapter)
    init(eventFactory: ISpeedRoommatingEventFactory, eventSourceAdapter: ISpeedRoommatingEventSourceAdapter)
    
    func listAllEvents(onComplete: @escaping (Result<[ISpeedRoommatingEvent], Error>) -> Void)
    func listAllEventsOrderedByStartTimeAscending(onComplete: @escaping (Result<[ISpeedRoommatingEvent], Error>) -> Void)
    func listAllEventsOnOrAfter(date: Date, onComplete: @escaping (Result<[ISpeedRoommatingEvent], Error>) -> Void)
    func listAllEventsByYear(onComplete: @escaping (Result<[Int:[ISpeedRoommatingEvent]], Error>) -> Void)
    func listAllEventsByYearThenMonth(onComplete: @escaping (Result<[Int:[Int:[ISpeedRoommatingEvent]]], Error>) -> Void)
}
