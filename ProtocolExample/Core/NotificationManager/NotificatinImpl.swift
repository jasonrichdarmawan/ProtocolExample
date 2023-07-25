//
//  NotificationManagerImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import UserNotifications

final class NotificationImpl: Notification {
    func isAuthorizedOrRequestAuthorization(completionHandler: @escaping (Bool) -> Void) {}
    
    func push(title: String, subtitle: String, sound: UNNotificationSound? = nil, completionHandler: @escaping (Bool) -> Void) {
    }
    
    func reset() -> NotificationResetEvent {
        return .IS_RESETTING
    }
}
