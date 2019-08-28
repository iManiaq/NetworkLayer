//
//  DataCacheManager.swift
//  N26CoinDesk
//
//  Created by Sachin on 09/04/17.
//  Copyright © 2017 sachin. All rights reserved.
//

import Foundation

class DataCacheManager: NSObject {
    
    static let historicDataCache = "historicDataCache"
    
    func archiveHistoricData(historicData : HistoricData) -> Data {
        return NSKeyedArchiver.archivedData(withRootObject: historicData)
    }
    
    func saveHistoricData(historicData: HistoricData) {
        let defaults = UserDefaults.standard
        let archivedObject = self.archiveHistoricData(historicData: historicData)
        defaults.set(archivedObject, forKey:  DataCacheManager.historicDataCache)
        defaults.synchronize()
    }
    
    func fetchStoredHistoricData() -> HistoricData? {
        var result: HistoricData?
        let defaults = UserDefaults.standard
        if let historicData = defaults.object(forKey: DataCacheManager.historicDataCache) as? Data {
            result = NSKeyedUnarchiver.unarchiveObject(with: historicData) as? HistoricData
        }
        return result
    }
    
}
