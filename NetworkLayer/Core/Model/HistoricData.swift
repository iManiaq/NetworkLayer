//
//  HistoricData.swift
//
//  Created by Sachin on 13/04/17.
//


import Foundation
import ObjectMapper
import UIKit

class HistoricData: AppModel, NSCoding {

    var bpiData: [String:Double]?
    var bpiCollection = [HistoricBPI]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.bpiData <- map["bpi"]
        self.constructBPICollection()
    }
    
    func constructBPICollection() {
        if let data = self.bpiData {
                for (date , rate) in data {
                    let historicBPI = HistoricBPI(date: date, rate: rate)
                    self.bpiCollection.append(historicBPI)
                }
            self.bpiCollection.sort(by: { $0.date.compare($1.date) == .orderedDescending})
        }
    }
    
    required public init() {
        super.init()
    }
    
    required public init?(map: Map) {
       super.init(map: map)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        self.bpiData = aDecoder.decodeObject(forKey: "bpiData") as? [String:Double]
        self.constructBPICollection()
    }
    
    
    func encode(with coder: NSCoder) {
        coder.encode(bpiData, forKey: "bpiData")
    }

}
