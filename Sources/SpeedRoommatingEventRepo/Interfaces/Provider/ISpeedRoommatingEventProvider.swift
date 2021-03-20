
public protocol ISpeedRoommatingEventProvider {
    
    init(eventSourceAdapter: ISpeedRoommatingEventSourceAdapter)
    init(eventFactory: ISpeedRoommatingEventFactory, eventSourceAdapter: ISpeedRoommatingEventSourceAdapter)
    
    func listAllEvents(onComplete: @escaping (Result<[ISpeedRoommatingEvent], Error>) -> Void)
}
