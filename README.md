# SpeedRoommatingEventRepository

A library for getting SpeedRoommatingEvents without worrying about it.

Get all events: unordered, unfiltered
```swift
let ep = SpeedRoommatingEventRepo.default
ep.listAllEvents {
    result in

    switch result {
    case .failure:
        break
    case let .success(events):
        // Do things with events
    }
}
```

Get all events: ordered
```swift
let ep = SpeedRoommatingEventRepo.default
ep.listAllEventsOrderedByStartTimeAscending {
    result in
    
    switch result {
    case .failure:
        break
    case let .success(events):
        // Do things with sorted events
    }
}
```

Get ordered events on or after specified date

```swift
let ep = SpeedRoommatingEventRepo.default
ep.listAllEventsOnOrAfter(date: Date()) {
    result in
    switch result {
    case .failure:
        break;
    case let .success(filteredEvents):
       // Do things with events you might actually be able to go to
    }
}
```

It is possible to use a different event source - see tests
