//
//  Date+Look.swift
//  N26CoinDesk
//
//  Created by Sachin on 08/04/17.
//  Copyright © 2017 sachin. All rights reserved.
//

import Foundation

extension Date {
    
    static var dateFormatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    var stringFromDate: String {
        return Date.dateFormatter.string(from: self)
    }
}
