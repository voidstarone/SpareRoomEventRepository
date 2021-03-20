//
//  SpeedRoommatingEvenstSourceJsonFileAdapter..swift
//  
//
//  Created by Thomas Lee on 20/03/2021.
//

import Foundation

internal enum SpeedRoommatingEventSourceJsonFileAdapterError : Error {
    case invalidData
    case invalidPath
}

internal struct SpeedRoommatingEventSourceJsonFileAdapterConfig {
    public let fileUrl: URL
}

public struct SpeedRoommatingEventSourceJsonFileAdapter : ISpeedRoommatingEventSourceAdapter {
    
    let config: SpeedRoommatingEventSourceJsonFileAdapterConfig
    
    init(config: SpeedRoommatingEventSourceJsonFileAdapterConfig) {
        self.config = config
    }

    public func listAllEventsAsDictionaries(onComplete: @escaping (Result<[[String : String]], Error>) -> Void) {
        do {
            let data = try Data(contentsOf: config.fileUrl)
            guard let rawDicts = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: String]] else {
                onComplete(.failure(SpeedRoommatingEventSourceJsonFileAdapterError.invalidData))
                return
            }
            // Ideally we wouldn't need to do this here since this would only be for caching
            let dicts = rawDicts.filter {
                rawDict in
                return !rawDict.isEmpty
            }
            onComplete(.success(dicts))
        } catch {
            onComplete(.failure(SpeedRoommatingEventSourceJsonFileAdapterError.invalidPath))
        }
    }
}
