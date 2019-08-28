//
//  NetworkAPIClient.swift
//
//  Created by Sachin on 13/04/17.
//


import UIKit
import Foundation
import Alamofire
import Security

typealias NetworkHTTPMethod = Alamofire.HTTPMethod
typealias NetworkRequest = Alamofire.Request
typealias NetworkNetworkManager = Alamofire.Session
typealias NetworkAPIClientCompletion = (_ result : AnyObject?, _ error : Error?) -> Void

public typealias NetworkCompletion = (_ error: NSError?) -> Void
public typealias NetworkResultCompletion = (_ result: AnyObject?, _ error: Error?) -> Void

class NetworkAPIClient: NSObject {
    
    static let TimeoutForRequest : TimeInterval = 90.0
    static let TimeoutForResource : TimeInterval = 90.0
    static let MaxRefreshTokenCount : Int = 10
    static let RefreshTokenInterval : TimeInterval = 1
    
    internal unowned var settingsProvider : AppSettingsProvider
    
    required init(settingsProvider : AppSettingsProvider) {
        self.settingsProvider = settingsProvider
        super.init()
    }
    
    internal func initCommon(settingsProvider : AppSettingsProvider) {
    }
    
    internal class var defaultSessionConfiguration : URLSessionConfiguration {
        get {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = NetworkAPIClient.TimeoutForRequest
            configuration.timeoutIntervalForResource = NetworkAPIClient.TimeoutForResource
            configuration.requestCachePolicy = .useProtocolCachePolicy
            configuration.isDiscretionary = true
            let cookies = HTTPCookieStorage.shared
            configuration.httpCookieStorage = cookies
            configuration.httpCookieAcceptPolicy = .always
            return configuration
        }
    }
    
    let manager : NetworkNetworkManager = {
        let manager = NetworkNetworkManager(configuration: NetworkAPIClient.defaultSessionConfiguration)
        return manager
    }()
    
    class var headers: [String: String] {
        get {
            var headers = [String: String]()
            headers["Accept"] = "application/json"
            return headers
        }
    }
    
}

