# SpeedRoommatingEventRepo

An interface for getting SpeedRoommatingEvents

Basic usage:
```
let ep = SpeedRoommatingEventProvider.default

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

It is possible to use a different event source - see tests
