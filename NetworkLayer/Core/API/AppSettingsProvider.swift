//
//  AppSettingsProvider.swift
//
//  Created by Sachin on 13/04/17.
//


import Foundation

final class AppSettingsProvider : NSObject {
    
    var server : String
    
    required init(server: String =  Bundle.value("ApplicationBaseURL"))  {
        self.server = server
        super.init()
    }
    
    class var applicationVersion: String {
        get {
            return self.stringForBundleKey(key: "CFBundleVersion")!
        }
    }
    
    class var bundleIdentifier: String {
        get {
            return Bundle.main.bundleIdentifier!
        }
    }
}

extension AppSettingsProvider {
    
    class func stringForBundleKey(key: String) -> String? {
        let value = Bundle.main.infoDictionary?[key] as? String
        return value
    }
    
    class func dictionaryForBundleKey(key: String) -> [String: AnyObject]? {
        let value = Bundle.main.infoDictionary?[key] as? [String: AnyObject]
        return value
    }
}

extension Bundle {
    class func value(_ key: String) -> String {
        return Bundle.main.infoDictionary?[key] as? String ?? ""
    }
}
