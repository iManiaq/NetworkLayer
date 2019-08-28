//
//  HistoricBPI.swift
//
//  Created by Sachin on 13/04/17.
//


import Foundation

class HistoricBPI: NSObject, NSCoding  {
    
    var date: Date = Date()
    var rate: Double?
    
    init(date: String, rate: Double) {
        self.date = Date.dateFormatter.date(from: date) ?? Date()
        self.rate = rate
    }
    
    convenience required init(coder aDecoder: NSCoder) {
        let theDate = aDecoder.decodeObject(forKey: "date") as? String ?? ""
        let theRate = aDecoder.decodeDouble(forKey: "rate") as Double
        self.init(date: theDate, rate: theRate)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(date, forKey: "date")
        coder.encode(rate, forKey: "rate")
    }
}

