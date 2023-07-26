//
//  NotificationManager.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 26/07/23.
//

import Foundation

final class NotificationManager {
    static var shared: Notification! {
        get {
            if sharedClosure == nil {
                sharedClosure = NotificationImpl.shared
            }
            
            return sharedClosure
        }
        set {
            sharedClosure = newValue
        }
    }
    
    private static var sharedClosure: Notification!
}
