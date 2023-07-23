//
//  NotifyWhenNearMRTStationOnceImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import Foundation

final class NotifyWhenNearMRTStationOnceImpl: NotifyWhenNearMRTStationOnce {
    var delegate: NotifyWhenNearMRTStationOnceDelegate?
    
    private var notifyWhenNearMRTStationWithBluetooth: NotifyWhenNearMRTStationWithBluetooth
    private var notifyWhenNearMRTStationWithGPS: NotifyWhenNearMRTStationWithGPS
    
    init(
        notifyWhenNearMRTStationWithBluetooth: NotifyWhenNearMRTStationWithBluetooth = NotifyWhenNearMRTStationWithBluetoothImpl(),
        notifyWhenNearMRTStationWithGPS: NotifyWhenNearMRTStationWithGPS = NotifyWhenNearMRTStationWithGPSImpl()
    ) {
        self.notifyWhenNearMRTStationWithBluetooth = notifyWhenNearMRTStationWithBluetooth
        self.notifyWhenNearMRTStationWithGPS = notifyWhenNearMRTStationWithGPS
        
        self.notifyWhenNearMRTStationWithBluetooth.delegate = self
        self.notifyWhenNearMRTStationWithGPS.delegate = self
    }
    
    func start() -> NotifyWhenNearMRTStationOnceStartEvent {
        return .IS_STARTING
    }
    
    func stop() -> NotifyWhenNearMRTStationOnceStopEvent {
        return .IS_STOPPING
    }
}

extension NotifyWhenNearMRTStationOnceImpl: NotifyWhenNearMRTStationWithBluetoothDelegate {
    func notifyManager(_ manager: NotifyWhenNearMRTStationWithBluetooth, didFind station: Station) {
        _ = stop()
        delegate?.notifyManager(self, didFind: station)
    }
}

extension NotifyWhenNearMRTStationOnceImpl: NotifyWhenNearMRTStationWithGPSDelegate {
    func notifyManager(_ manager: NotifyWhenNearMRTStationWithGPS, didFind station: Station) {
        _ = stop()
        delegate?.notifyManager(self, didFind: station)
    }
}
