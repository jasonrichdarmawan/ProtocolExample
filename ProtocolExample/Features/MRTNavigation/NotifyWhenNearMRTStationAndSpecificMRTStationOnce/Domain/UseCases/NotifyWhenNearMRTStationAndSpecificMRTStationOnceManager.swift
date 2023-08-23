//
//  NotifyWhenNearMRTStationAndSpecificMRTStationOnceManager.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/08/23.
//

import Foundation

final class NotifyWhenNearMRTStationAndSpecificMRTStationOnceManager {
    fileprivate init() {}
    
    static weak var shared: NotifyWhenNearMRTStationAndSpecificMRTStationOnce! {
        get {
            var temp: NotifyWhenNearMRTStationAndSpecificMRTStationOnce
            
            if sharedClosure == nil {
                temp = NotifyWhenNearMRTStationAndSpecificMRTStationOnceImpl.shared
                sharedClosure = temp
            }
            
            return sharedClosure
        }
    }
    
    private static weak var sharedClosure: NotifyWhenNearMRTStationAndSpecificMRTStationOnce?
}
