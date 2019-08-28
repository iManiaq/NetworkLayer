//
//  CurrentBPI.swift
//
//  Created by Sachin on 13/04/17.
//


import Foundation
import ObjectMapper
import UIKit

class CurrentBPI: AppModel, NSCoding {
    
    var code: String?
    var symbol: String?
    var rate: String?
    var bpiDescription: String?
    var rateFloat: Double?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.code <- map["code"]
        self.symbol <- map["symbol"]
        self.rate <- map["rate"]
        self.bpiDescription <- map["description"]
        self.rateFloat <- map["rate_float"]
    }
    
    required public init() {
        super.init()
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        self.code = aDecoder.decodeObject(forKey: "code") as? String
        self.symbol = aDecoder.decodeObject(forKey: "symbol") as? String
        self.rate = aDecoder.decodeObject(forKey: "rate") as? String
        self.bpiDescription = aDecoder.decodeObject(forKey: "bpiDescription") as? String
        self.rateFloat = aDecoder.decodeObject(forKey: "symbol") as? Double
    }
    
    
    func encode(with coder: NSCoder) {
        coder.encode(code, forKey: "code")
        coder.encode(symbol, forKey: "symbol")
        coder.encode(rate, forKey: "rate")
        coder.encode(bpiDescription, forKey: "bpiDescription")
        coder.encode(rateFloat, forKey: "rateFloat")
    }
}
