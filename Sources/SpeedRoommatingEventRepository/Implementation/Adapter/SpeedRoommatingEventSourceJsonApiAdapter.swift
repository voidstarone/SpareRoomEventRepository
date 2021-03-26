//
//  SpeedRoommatingEventSourceJsonApiAdapter.swift
//  
//
//  Created by Thomas Lee on 18/03/2021.
//

import Foundation

internal struct SpeedRoommatingEventSourceJsonApiAdapterConfig {
    public let apiUrl: URL
    public let secretKey: String
}

internal enum SpeedRoommatingEventSourceJsonApiAdapterError : Error {
    case noData
    case invalidData
    case noConnection
    case badKey
    case badPath
    case badRequest
    case serverError
    case timeout
}

public struct SpeedRoommatingEventSourceJsonApiAdapter : ISpeedRoommatingEventSourceAdapter {
    
    private var config: SpeedRoommatingEventSourceJsonApiAdapterConfig =
        SpeedRoommatingEventSourceJsonApiAdapterConfig(
            apiUrl: URL(string: "https://api.jsonbin.io/b/6050a8a3683e7e079c519892")!,
            secretKey: "$2b$10$76APFiNwr0YXKLX6FDCGiuks/TPFnSKkJleMY2uz1AR1EqTK9IODC"
    )

    
    init() {}
    
    init(config: SpeedRoommatingEventSourceJsonApiAdapterConfig) {
        self.config = config
    }
    
    private func lookUpError(byStatusCode statusCode: Int) -> SpeedRoommatingEventSourceJsonApiAdapterError? {
        switch statusCode {
        case 401:
            // Ideally we'd have something in here to log the error messages, but omitted due to time.
            return SpeedRoommatingEventSourceJsonApiAdapterError.badKey
        case 404:
            return SpeedRoommatingEventSourceJsonApiAdapterError.badPath
        case 408:
            return SpeedRoommatingEventSourceJsonApiAdapterError.timeout
        case 422:
            return SpeedRoommatingEventSourceJsonApiAdapterError.badRequest
        case 500...599:
            return SpeedRoommatingEventSourceJsonApiAdapterError.serverError
        default:
            break
        }
        return nil
    }
    
    public func listAllEventsAsDictionaries(onComplete: @escaping (Result<[[String:String]], Error>) -> Void) {
        let apiUrl = config.apiUrl
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(config.secretKey, forHTTPHeaderField: "secret-key")
        
        // Ideally this would be abstracted so we could mock no connection
        // Which would also allow us to fully cover lookUpError
        let session = URLSession.shared
        let task = session.dataTask(with: request) {
            data, response, requestError in
            do {
                if requestError != nil {
                    onComplete(.failure(SpeedRoommatingEventSourceJsonApiAdapterError.timeout))
                    return
                }
                // If this cast fails I have bigger problems than I can handle
                let statusCode = (response as! HTTPURLResponse).statusCode
                if let error = self.lookUpError(byStatusCode: statusCode) {
                    onComplete(.failure(error))
                    return
                }
                
                if data == nil {
                    onComplete(.failure(SpeedRoommatingEventSourceJsonApiAdapterError.noData))
                    return
                }
                guard let rawDicts = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [[String: String]] else {
                    onComplete(.failure(SpeedRoommatingEventSourceJsonApiAdapterError.invalidData))
                    return
                }
                // Remove obvious crap.
                let dicts = rawDicts.filter {
                    rawDict in
                    return !rawDict.isEmpty
                }
                onComplete(.success(dicts))
            } catch {
                onComplete(.failure(error))
            }
            
        }
        task.resume()
    }
}
