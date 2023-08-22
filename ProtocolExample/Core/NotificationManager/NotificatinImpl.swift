//
//  NotificationManagerImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import UserNotifications

final class NotificationImpl: Notification {
    fileprivate init() {
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    deinit {
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    func isAuthorizedOrRequestAuthorization(completionHandler: @escaping (Bool) -> Void) {}
    
    func push(title: String, subtitle: String, sound: UNNotificationSound? = nil, completionHandler: @escaping (Bool) -> Void) {
    }
    
    func reset() -> NotificationResetEvent {
        return .IS_RESETTING
    }
}

extension NotificationImpl {
    static var shared: Notification! {
        get {
            if sharedClosure == nil {
                sharedClosure = NotificationImpl()
            }
            
            return sharedClosure
        }
        set {
            sharedClosure = newValue
        }
    }
    
    private static var sharedClosure: Notification!
}
