//
//  NotifyWhenNearMRTStationWhenInBackgroundImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import UIKit

final class NotifyWhenNearMRTStationWhenInBackgroundImpl: NotifyWhenNearMRTStationWhenInBackground {
    var delegate: NotifyWhenNearMRTStationWhenInBackgroundDelegate?
    
    private var notifyWithBluetooth: NotifyWhenNearMRTStationWithBluetooth
    private var notifyWithGPS: NotifyWhenNearMRTStationWithGPS
    private var notification: Notification
    
    private var currentStation: Station?
    
    init(
        notifyWithBluetooth: NotifyWhenNearMRTStationWithBluetooth = NotifyWhenNearMRTStationWithBluetoothImpl(),
        notifyWithGPS: NotifyWhenNearMRTStationWithGPS = NotifyWhenNearMRTStationWithGPSImpl(),
        notification: Notification = NotificationManager.shared
    ) {
        self.notifyWithBluetooth = notifyWithBluetooth
        self.notifyWithGPS = notifyWithGPS
        self.notification = notification
        
        self.notifyWithBluetooth.delegate = self
        self.notifyWithGPS.delegate = self
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    deinit {
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    func start() -> NotifyWhenNearMRTStationWhenInBackgroundStartEvent {
        return .IS_STARTING
    }
    
    func stop() -> NotifyWhenNearMRTStationWhenInBackgroundStopEvent {
        return .IS_STOPPING
    }
}

extension NotifyWhenNearMRTStationWhenInBackgroundImpl: NotifyWhenNearMRTStationWithBluetoothDelegate {
    func notifyManager(_ manager: NotifyWhenNearMRTStationWithBluetooth, didFind station: Station) {
        if currentStation == station { return }
        
        currentStation = station
        
        switch UIApplication.shared.applicationState {
        case .active: break
        case .background, .inactive:
            _ = notification.push(title: "", subtitle: "", sound: nil, completionHandler: { _ in })
            // TODO
            break
        @unknown default: break
        }
    }
}

extension NotifyWhenNearMRTStationWhenInBackgroundImpl: NotifyWhenNearMRTStationWithGPSDelegate {
    func notifyManager(_ manager: NotifyWhenNearMRTStationWithGPS, didFind station: Station) {
        if currentStation == station { return }
        
        currentStation = station
        
        switch UIApplication.shared.applicationState {
        case .active: break
        case .background, .inactive:
            _ = notification.push(title: "", subtitle: "", sound: nil, completionHandler: { _ in })
            // TODO
            break
        @unknown default: break
        }
    }
}
