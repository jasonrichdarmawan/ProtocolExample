//
//  NotifyWhenNearMRTStationWhenInBackgroundImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import UIKit

final class NotifyWhenNearMRTStationWhenInBackgroundImpl: NotifyWhenNearMRTStationWhenInBackground {
    var delegate: NotifyWhenNearMRTStationWhenInBackgroundDelegate?
    
    private var notifyWhenNearMRTStationWithBluetooth: NotifyWhenNearMRTStationWithBluetooth
    private var notifyWhenNearMRTStationWithGPS: NotifyWhenNearMRTStationWithGPS
    private var notificationManager: NotificationManager
    
    private var currentStation: Station?
    
    init(
        notifyWhenNearMRTStationWithBluetooth: NotifyWhenNearMRTStationWithBluetooth = NotifyWhenNearMRTStationWithBluetoothImpl(),
        notifyWhenNearMRTStationWithGPS: NotifyWhenNearMRTStationWithGPS = NotifyWhenNearMRTStationWithGPSImpl(),
        notificationManager: NotificationManager = NotificationManagerImpl()
    ) {
        self.notifyWhenNearMRTStationWithBluetooth = notifyWhenNearMRTStationWithBluetooth
        self.notifyWhenNearMRTStationWithGPS = notifyWhenNearMRTStationWithGPS
        self.notificationManager = notificationManager
        
        self.notifyWhenNearMRTStationWithBluetooth.delegate = self
        self.notifyWhenNearMRTStationWithGPS.delegate = self
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
            _ = notificationManager.push(title: "", subtitle: "", sound: nil, completionHandler: { _ in })
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
            _ = notificationManager.push(title: "", subtitle: "", sound: nil, completionHandler: { _ in })
            // TODO
            break
        @unknown default: break
        }
    }
}
