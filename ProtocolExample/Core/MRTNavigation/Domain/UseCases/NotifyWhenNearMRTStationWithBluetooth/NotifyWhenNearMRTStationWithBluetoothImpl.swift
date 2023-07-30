//
//  NotifyWhenNearMRTStationWithBluetoothImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import Foundation

final class NotifyWhenNearMRTStationWithBluetoothImpl: NotifyWhenNearMRTStationWithBluetooth {
    var delegate: NotifyWhenNearMRTStationWithBluetoothDelegate?
    
    private var beaconFinder: BeaconFinder
    
    init(beaconFinder: BeaconFinder = BeaconFinderImpl()) {
        self.beaconFinder = beaconFinder
    }
    
    func start() -> NotifyWhenNearMRTStationWithBluetoothStartEvent {
        return .IS_STARTING
    }
    
    func stop() -> NotifyWhenNearMRTStationWithBluetoothStopEvent {
        return .IS_STOPPING
    }
}
