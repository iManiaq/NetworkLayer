//
//  ModelManager.swift
//  N26CoinDesk
//
//  Created by Sachin on 08/04/17.
//  Copyright © 2017 sachin. All rights reserved.
//

import Foundation

class ModelManager: NSObject {
    var request: NetworkRequest?
    private var processing = false
    var isProcessing: Bool {
        get {
            if let alamofireRequest = request {
                return alamofireRequest.task?.state == .running
            } else {
                return processing
            }
        } set {
            processing = newValue
        }
    }
}
