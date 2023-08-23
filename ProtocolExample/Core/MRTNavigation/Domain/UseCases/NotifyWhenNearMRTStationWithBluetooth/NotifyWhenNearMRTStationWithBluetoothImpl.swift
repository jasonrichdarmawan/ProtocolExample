//
//  NotifyWhenNearMRTStationWithBluetoothImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import Foundation
import CoreLocation

final class NotifyWhenNearMRTStationWithBluetoothImpl: NotifyWhenNearMRTStationWithBluetooth {
    weak var delegate: NotifyWhenNearMRTStationWithBluetoothDelegate?

    private var beaconFinder: BeaconFinder
    
    private var constraint: CLBeaconIdentityConstraint?
    
    fileprivate init(beaconFinder: BeaconFinder = BeaconFinderManager.shared) {
        self.beaconFinder = beaconFinder
        self.beaconFinder.delegate = self
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    deinit {
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    func start() -> NotifyWhenNearMRTStationWithBluetoothStartEvent {
        guard let beaconUUID = MRT.beaconUUID else { return .BAD_REQUEST }
        constraint = CLBeaconIdentityConstraint(uuid: beaconUUID)
        guard let constraint = constraint else { return .BAD_REQUEST }
        
        let result = beaconFinder.start(constraint: constraint)
        
        switch result {
        case .IS_STARTING: return .IS_STARTING
        case .NOT_AUTHORIZED: return .NOT_AUTHORIZED
        }
    }
    
    func stop() -> NotifyWhenNearMRTStationWithBluetoothStopEvent {
        let result = beaconFinder.stop()
        
        switch result {
        case .IS_STOPPING: return .IS_STOPPING
        }
    }
}

extension NotifyWhenNearMRTStationWithBluetoothImpl: BeaconFinderDelegate {
    func notifyManager(_ manager: BeaconFinder, didRange beaconConstraints: [CLBeaconIdentityConstraint : [CLBeacon]]) {
        guard let constraint else { return }
        
        guard let beacons = beaconConstraints[constraint] else { return }
        
        let proximityBeacons = beacons.filter( { $0.proximity != .unknown })
        
        guard !proximityBeacons.isEmpty else { return }
        
        let sortedByProximityBeacons = proximityBeacons.sorted { beacon1, beacon2 in return beacon1.proximity.rawValue < beacon2.proximity.rawValue }
        
        for beacon in sortedByProximityBeacons {
            if let station = MRT.stations.first(where: { $0.major == beacon.major.uint16Value }) {
                delegate?.notifyManager(self, didFind: station)
                break
            }
        }
    }
}

extension NotifyWhenNearMRTStationWithBluetoothImpl {
    static weak var shared: NotifyWhenNearMRTStationWithBluetooth! {
        get {
            var temp: NotifyWhenNearMRTStationWithBluetoothImpl
            
            if sharedClosure == nil {
                temp = NotifyWhenNearMRTStationWithBluetoothImpl()
                sharedClosure = temp
            }
            
            return sharedClosure
        }
    }
    
    private static weak var sharedClosure: NotifyWhenNearMRTStationWithBluetooth?
}
