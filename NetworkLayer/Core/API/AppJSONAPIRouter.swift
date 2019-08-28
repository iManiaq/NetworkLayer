//
//  AppJSONAPIRouter.swift
//
//  Created by Sachin on 13/04/17.
//


import Foundation
import Alamofire
import ObjectMapper

enum AppJSONAPIRouter {

    case historicalData(fromDate: Date ,toDate: Date)
    case realTimeData
    
    var path: String {
        var path : String = ""
        switch self {
        case .historicalData(_):
            path = "/v1/bpi/historical/close.json"
        case .realTimeData:
            path = "/v1/bpi/currentprice.json"
        }
        return path
    }
    
    var body : Data? {
        let bodyString: String? = nil
        switch self {
            // In case of values to be added to any API request
        default: break
        }
        return bodyString?.data(using: String.Encoding.utf8)
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .historicalData, .realTimeData :
            return .get
        }
    }
    
    var headers : [String : String] {
        var headers = [String : String]()
        headers["Accept"] = "application/json"
        headers["Content-Type"] = "application/json"
        return headers
    }
    
    var parameters : [String : String] {
        var parameters = [String : String]()
        switch self {
        case .historicalData(let fromDate ,let toDate):
            parameters[DataParameter.start] = fromDate.stringFromDate
            parameters[DataParameter.end] = toDate.stringFromDate
            break
        default: break
        }
        return parameters
    }
}

struct DataParameter {
    static let start = "start"
    static let end = "end"
}
