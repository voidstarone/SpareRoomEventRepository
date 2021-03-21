//
//  File.swift
//  
//
//  Created by Thomas Lee on 20/03/2021.
//


import Foundation
import XCTest

@testable import SpeedRoommatingEventRepository


final class SpeedRoommatingEventFactoryTests: XCTestCase {
    var factory: ISpeedRoommatingEventFactory!
    
    override func setUp() {
        self.factory = SpeedRoommatingEventFactory()
    }
    
    func testDictGoodValues() {
        let event = factory.createRoommatingEvent(fromDict:[
            "cost":"free",
            "end_time":"2021-06-20T09:09:18Z",
            "image_url":"https://images.unsplash.com/photo-1491333078588-55b6733c7de6",
            "location":"The Spot Karaoke Lounge",
            "start_time":"2021-06-18T12:09:18Z",
            "venue":"Manhattan"
        ])
        
        XCTAssertNotNil(event)
    }
    
    func testDictBadCost() {
        var event = factory.createRoommatingEvent(fromDict:[
            "cost":"",
            "end_time":"2021-06-20T09:09:18Z",
            "image_url":"https://images.unsplash.com/photo-1491333078588-55b6733c7de6",
            "location":"The Spot Karaoke Lounge",
            "start_time":"2021-06-18T12:09:18Z",
            "venue":"Manhattan"
        ])
        
        XCTAssertNil(event)
        
        event = factory.createRoommatingEvent(fromDict:[
            "end_time":"2021-06-20T09:09:18Z",
            "image_url":"https://images.unsplash.com/photo-1491333078588-55b6733c7de6",
            "location":"The Spot Karaoke Lounge",
            "start_time":"2021-06-18T12:09:18Z",
            "venue":"Manhattan"
        ])
        
        XCTAssertNil(event)
    }
    
    func testDictBadEndTime() {
        var event = factory.createRoommatingEvent(fromDict:[
            "cost":"",
            "end_time":"",
            "image_url":"https://images.unsplash.com/photo-1491333078588-55b6733c7de6",
            "location":"The Spot Karaoke Lounge",
            "start_time":"2021-06-18T12:09:18Z",
            "venue":"Manhattan"
        ])
        
        XCTAssertNil(event)
        
        event = factory.createRoommatingEvent(fromDict:[
            "cost":"free",
            "image_url":"https://images.unsplash.com/photo-1491333078588-55b6733c7de6",
            "location":"The Spot Karaoke Lounge",
            "start_time":"2021-06-18T12:09:18Z",
            "venue":"Manhattan"
        ])
        
        XCTAssertNil(event)
    }
}
