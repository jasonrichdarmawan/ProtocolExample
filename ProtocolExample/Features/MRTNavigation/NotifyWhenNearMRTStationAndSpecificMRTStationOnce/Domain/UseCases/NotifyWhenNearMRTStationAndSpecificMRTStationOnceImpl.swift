//
//  NotifyWhenNearMRTStationAndSpecificMRTStationOnceImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import Foundation

final class NotifyWhenNearMRTStationAndSpecificMRTStationOnceImpl: NotifyWhenNearMRTStationAndSpecificMRTStationOnce {
    weak var delegate: NotifyWhenNearMRTStationAndSpecificMRTStationOnceDelegate?
    
    private var notifyWithBluetooth: NotifyWhenNearMRTStationWithBluetooth
    private var notifyWithGPS: NotifyWhenNearMRTStationWithGPS
    
    private var currentStation: Station?
    
    private var arrival: Station?
    
    init(
        notifyWithBluetooth: NotifyWhenNearMRTStationWithBluetooth = NotifyWhenNearMRTStationWithBluetoothImpl(),
        notifyWithGPS: NotifyWhenNearMRTStationWithGPS = NotifyWhenNearMRTStationWithGPSImpl()
    ) {
        self.notifyWithBluetooth = notifyWithBluetooth
        self.notifyWithGPS = notifyWithGPS
        
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
    
    func start(arrival: Station) -> NotifyWhenNearMRTStationAndSpecificMRTStationOnceStartEvent {
        self.arrival = arrival
        return .IS_STARTING
    }
    
    func stop() -> NotifyWhenNearMRTStationAndSpecificMRTStationOnceStopEvent {
        return .IS_STOPPING
    }
}

extension NotifyWhenNearMRTStationAndSpecificMRTStationOnceImpl: NotifyWhenNearMRTStationWithBluetoothDelegate {
    func notifyManager(_ manager: NotifyWhenNearMRTStationWithBluetooth, didFind station: Station) {
        if currentStation == station { return }
        
        currentStation = station
        
        if arrival == station { _ = stop() }
        
        delegate?.notifyManager(self, didFind: station, didEvent: arrival == station ? .ARRIVED : .FOUND)
    }
}

extension NotifyWhenNearMRTStationAndSpecificMRTStationOnceImpl: NotifyWhenNearMRTStationWithGPSDelegate {
    func notifyManager(_ manager: NotifyWhenNearMRTStationWithGPS, didFind station: Station) {
        if currentStation == station { return }
        
        currentStation = station
        
        if arrival == station { _ = stop() }
        
        delegate?.notifyManager(self, didFind: station, didEvent: arrival == station ? .ARRIVED : .FOUND)
    }
}
