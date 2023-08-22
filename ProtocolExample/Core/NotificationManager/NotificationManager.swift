//
//  NotificationManager.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 26/07/23.
//

import Foundation

final class NotificationManager {
    static weak var shared: Notification! {
        get {
            var temp: Notification
            
            if sharedClosure == nil {
                temp = NotificationImpl.shared
                sharedClosure = temp
            }
            
            return sharedClosure
        }
    }
    
    private static weak var sharedClosure: Notification?
}



