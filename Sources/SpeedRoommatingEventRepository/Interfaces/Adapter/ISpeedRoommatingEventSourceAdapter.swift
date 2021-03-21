//
//  File.swift
//  
//
//  Created by Thomas Lee on 18/03/2021.
//

import Foundation

public protocol ISpeedRoommatingEventSourceAdapter {
    func listAllEventsAsDictionaries(onComplete: @escaping (Result<[[String:String]], Error>) -> Void)
}
