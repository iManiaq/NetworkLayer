//
//  Created by Sachin on 13/04/17.
//


import UIKit
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class AppModel: NSObject ,Mappable {
    
    override required public init() {
        super.init()
    }
    
    required public init?(map: Map){
        super.init()
    }
    
    public func mapping(map: Map) {
        
    }
}
