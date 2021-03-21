# SpeedRoommatingEventRepository

An interface for getting SpeedRoommatingEvents

Basic usage:
```
let ep = SpeedRoommatingEventRepo.default
ep.listAllEvents {
    result in

    switch result {
    case .failure:
        break
    case let .success(events):
        // do things with events
    }
}
```
```
let ep = SpeedRoommatingEventRepo.default
ep.listAllEventsOrderedByStartTimeAscending {
    result in
    
    switch result {
    case .failure:
        break
    case let .success(events):
        // do things with sorted events
    }
}
```

It is possible to use a different event source - see tests
