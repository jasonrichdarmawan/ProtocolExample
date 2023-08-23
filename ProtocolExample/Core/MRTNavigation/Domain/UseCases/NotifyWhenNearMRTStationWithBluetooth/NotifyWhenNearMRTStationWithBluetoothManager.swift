//
//  NotifyWhenNearMRTStationWithBluetoothManager.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/08/23.
//

import Foundation

final class NotifyWhenNearMRTStationWithBluetoothManager {
    fileprivate init() {}
    
    static weak var shared: NotifyWhenNearMRTStationWithBluetooth! {
        get {
            var temp: NotifyWhenNearMRTStationWithBluetooth
            
            if sharedClosure == nil {
                temp = NotifyWhenNearMRTStationWithBluetoothImpl.shared
                sharedClosure = temp
            }
            
            return sharedClosure
        }
    }
    
    private static weak var sharedClosure: NotifyWhenNearMRTStationWithBluetooth?
}
