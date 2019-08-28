//  MVVMDemo
//
//  Created by Sachin on 13/04/17.
//


import Foundation

class AppModule {
    
    static let sharedModule = AppModule()
    
    var settingsProvider : AppSettingsProvider!
    var apiClient : NetworkAPIClient!
    let reachability = Reachability()!
    
    private init() {
        self.setupServer()
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged),name: ReachabilityChangedNotification,object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }

    private func setupServer() {
        settingsProvider = AppSettingsProvider()
        apiClient = NetworkAPIClient(settingsProvider: settingsProvider)
    }
    
    deinit {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self,name: ReachabilityChangedNotification,object: reachability)
    }
    
    //MARK: Network Rechability
    @objc func reachabilityChanged(note: NSNotification) {
        
        let reachability = note.object as! Reachability
        
        if reachability.isReachable {
            if  self.reachability.isReachableViaWiFi {
                networkReachableAction()
                print("Reachable via WiFi")
            } else {
                networkReachableAction()
                print("Reachable via Cellular")
            }
        } else {
            networkUnreachableAction()
            print("Network not reachable")
        }
    }
    func networkReachableAction() {
        NotificationCenter.default.post(name: ReachabilityPost.statusChanged.notification ,object: nil, userInfo: nil)
    }
    
    //MARK: Network Rechability - network Unreachable Action
    func networkUnreachableAction() {
        NotificationCenter.default.post(name: ReachabilityPost.statusChanged.notification ,object: nil, userInfo: nil)
    }

}

enum ReachabilityPost: String {
    case statusChanged = "statusChangedNotification"
    var notification : Notification.Name  {
        return Notification.Name(rawValue: self.rawValue )
    }
}

