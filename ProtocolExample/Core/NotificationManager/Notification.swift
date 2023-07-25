//
//  NotificationManager.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import Foundation
import UserNotifications

protocol Notification {
    /// please show alert in view if return false
    func isAuthorizedOrRequestAuthorization(completionHandler: @escaping (Bool) -> Void)
    
    func push(title: String, subtitle: String, sound: UNNotificationSound?, completionHandler: @escaping (Bool) -> Void)
    func reset() -> NotificationResetEvent
}

protocol NotificationEvent {}

enum NotificationPushEvent: NotificationEvent { case IS_PUSHING, NOT_AUTHORIZED }

enum NotificationResetEvent: NotificationEvent { case IS_RESETTING }
