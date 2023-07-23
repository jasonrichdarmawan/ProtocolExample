//
//  NotificationManager.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import Foundation
import UserNotifications

protocol NotificationManager {
    /// please show alert in view if return false
    func isAuthorizedOrRequestAuthorization(completionHandler: (Bool) -> Void)
    
    func push(title: String, subtitle: String, sound: UNNotificationSound?, completionHandler: (Bool) -> Void)
    func reset() -> NotificationManagerResetEvent
}

protocol NotificationManagerEvent {}

enum NotificationManagerPushEvent: NotificationManagerEvent { case IS_PUSHING, NOT_AUTHORIZED }

enum NotificationManagerResetEvent: NotificationManagerEvent { case IS_RESETTING }
