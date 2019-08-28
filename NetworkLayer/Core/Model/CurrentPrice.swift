//
//  CurrentPrice.swift
//
//  Created by Sachin on 13/04/17.
//


import Foundation
import ObjectMapper
import UIKit

class CurrentPrice: AppModel, NSCoding {
    
    var bpiUSD: CurrentBPI?
    var bpiGBP: CurrentBPI?
    var bpiEUR: CurrentBPI?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.bpiUSD <- map["USD"]
        self.bpiGBP <- map["GBP"]
        self.bpiEUR <- map["EUR"]
    }
    
    required public init() {
        super.init()
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        self.bpiUSD = aDecoder.decodeObject(forKey: "bpiUSD") as? CurrentBPI
        self.bpiGBP = aDecoder.decodeObject(forKey: "bpiGBP") as? CurrentBPI
        self.bpiEUR = aDecoder.decodeObject(forKey: "bpiEUR") as? CurrentBPI
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(bpiUSD, forKey: "bpiUSD")
        coder.encode(bpiGBP, forKey: "bpiGBP")
        coder.encode(bpiEUR, forKey: "bpiEUR")
    }
}
