//
//  NotifyWhenNearMRTStationWithGPSManager.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/08/23.
//

import Foundation

final class NotifyWhenNearMRTStationWithGPSManager {
    fileprivate init() {}
    
    static weak var shared: NotifyWhenNearMRTStationWithGPS! {
        get {
            var temp: NotifyWhenNearMRTStationWithGPS
            
            if sharedClosure == nil {
                temp = NotifyWhenNearMRTStationWithGPSImpl.shared
                sharedClosure = temp
            }
            
            return sharedClosure
        }
    }
    
    private static weak var sharedClosure: NotifyWhenNearMRTStationWithGPS?
}
