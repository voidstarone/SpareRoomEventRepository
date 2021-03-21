//
//  File.swift
//  
//
//  Created by Thomas Lee on 19/03/2021.
//

import Foundation
@testable import SpeedRoommatingEventRepository

struct MockSpeedRoommatingEventSourceAdapterSuccessful : ISpeedRoommatingEventSourceAdapter {
    var eventFactory: ISpeedRoommatingEventFactory = MockSpeedRoommatingEventFactory()
    
    init() {}

    func listAllEventsAsDictionaries(onComplete: @escaping (Result<[[String:String]], Error>) -> Void) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let events: [[String:String]] = [
            ["cost":"free",
            "end_time":"2021-06-11T22:09:19Z",
            "image_url":"https://images.unsplash.com/photo-1543007630-9710e4a00a20",
            "location":"The Spot Karaoke Lounge",
            "start_time":"2021-06-08T12:09:19Z",
            "venue":"Manhattan"],
            ["cost":"free",
             "end_time":"2021-02-11T18:09:19Z",
             "image_url":"https://images.unsplash.com/photo-1582642017153-e36e8796b3f8",
             "location":"The Spot Karaoke Lounge",
             "start_time":"2021-02-11T12:09:19Z",
             "venue":"Brooklyn"],
            ["cost":"free",
             "end_time":"2021-04-06T13:09:19Z",
             "image_url":"https://images.unsplash.com/photo-1582642017153-e36e8796b3f8",
             "location":"WeWork, 115 Broadway",
             "start_time":"2021-04-02T12:09:19Z",
             "venue":"Brooklyn"]
        ]
        onComplete(.success(events))
    }
}
