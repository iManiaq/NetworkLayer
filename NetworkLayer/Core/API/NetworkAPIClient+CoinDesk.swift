//
//  NetworkAPIClient+CoinDesk.swift
//  MVVMDemo
//
//  Created by Sachin on 13/04/17.
//


import Foundation
import Alamofire

extension NetworkAPIClient {

    /// To get last two weeks CoinDesk data from current date
    ///
    /// - Parameter completion: NetworkAPIClientCompletion result data and error
    /// - Returns: retuns the realTime data or Error after the success / failure of API call
    func getHistoricalData(completion: @escaping NetworkAPIClientCompletion) -> NetworkRequest? {
        let today = Date() // from today
        let lastTwoWeeks = Calendar.current.date(byAdding: .day, value: -15, to: Date()) // last two weeks data to be fetched
        guard let theLastTwoWeek = lastTwoWeeks else { return nil }
        // Continue if LastTwoWeek is a valid date
        let mutableRequest = self.urlRequest(route: .historicalData(fromDate: theLastTwoWeek, toDate: today))
        let theRequest = self.requestModel(request: mutableRequest as URLRequest , completion: { (result: HistoricData?, error: Error?) in
            completion(result as AnyObject?, error)
        })
        return theRequest
    }
    

    /// To get Real time data from CoinDesk
    ///
    /// - Parameter completion: NetworkAPIClientCompletion result data and error
    /// - Returns: retuns the realTime data or Error after the success / failure of API call
    func getRealTimeData(completion: @escaping NetworkAPIClientCompletion) -> NetworkRequest? {
        let mutableRequest = self.urlRequest(route: .realTimeData)
        let theRequest = self.requestModel(request: mutableRequest as URLRequest ,keyPath : "bpi", completion: { (result: CurrentPrice?, error: Error?) in
            completion(result as AnyObject?, error)
        })
        return theRequest
    }
    
   
}



    
