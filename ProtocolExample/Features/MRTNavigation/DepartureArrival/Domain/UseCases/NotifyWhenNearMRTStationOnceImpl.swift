//
//  NotifyWhenNearMRTStationOnceImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import Foundation

final class NotifyWhenNearMRTStationOnceImpl: NotifyWhenNearMRTStationOnce {
    weak var delegate: NotifyWhenNearMRTStationOnceDelegate?
    
    private var notifyWithBeacon: NotifyWhenNearMRTStationWithBluetooth
    private var notifyWithGPS: NotifyWhenNearMRTStationWithGPS
    
    fileprivate init(
        notifyWithBeacon: NotifyWhenNearMRTStationWithBluetooth = NotifyWhenNearMRTStationWithBluetoothManager.shared,
        notifyWithGPS: NotifyWhenNearMRTStationWithGPS = NotifyWhenNearMRTStationWithGPSManager.shared
    ) {
        self.notifyWithBeacon = notifyWithBeacon
        self.notifyWithGPS = notifyWithGPS
        
        self.notifyWithBeacon.delegate = self
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
    
    func start() -> NotifyWhenNearMRTStationOnceStartEvent {
        let beaconResult = notifyWithBeacon.start()
        
        switch beaconResult {
        case .BAD_REQUEST: return .NOT_AUTHORIZED
        case .NOT_AUTHORIZED: return .NOT_AUTHORIZED
        case .IS_STARTING: break
        }
        
        let gpsResult = notifyWithGPS.start()
        
        switch gpsResult {
        case .NOT_AUTHORIZED: return .NOT_AUTHORIZED
        case .IS_STARTING: break
        }
        
        return .IS_STARTING
    }
    
    func stop() -> NotifyWhenNearMRTStationOnceStopEvent {
        let beaconResult = notifyWithBeacon.stop()
        
        switch beaconResult {
        case .IS_STOPPING: break
        }
        
        let gpsResult = notifyWithGPS.stop()
        
        switch gpsResult {
        case .IS_STOPPING: break
        }
        
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

extension NotifyWhenNearMRTStationOnceImpl {
    static weak var shared: NotifyWhenNearMRTStationOnce! {
        get {
            var temp: NotifyWhenNearMRTStationOnce
            
            if sharedClosure == nil {
                temp = NotifyWhenNearMRTStationOnceImpl()
                sharedClosure = temp
            }
            
            return sharedClosure
        }
    }
    
    private static weak var sharedClosure: NotifyWhenNearMRTStationOnce?
}
