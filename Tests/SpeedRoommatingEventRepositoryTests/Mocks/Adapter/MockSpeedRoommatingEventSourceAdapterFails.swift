//
//  File.swift
//  
//
//  Created by Thomas Lee on 21/03/2021.
//

import Foundation
@testable import SpeedRoommatingEventRepository


enum MockError : Error {
    case mock
}

struct MockEventSourceAdapterFailure : ISpeedRoommatingEventSourceAdapter {
    var eventFactory: ISpeedRoommatingEventFactory = MockSpeedRoommatingEventFactory()
    
    init() {}
    
    func listAllEventsAsDictionaries(onComplete: @escaping (Result<[[String:String]], Error>) -> Void) {
        onComplete(.failure(MockError.mock))
    }
}
