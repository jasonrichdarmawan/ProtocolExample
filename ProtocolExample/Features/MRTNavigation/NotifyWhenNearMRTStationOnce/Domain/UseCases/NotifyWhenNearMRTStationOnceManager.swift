//
//  NotifyWhenNearMRTStationOnceManager.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/08/23.
//

import Foundation

final class NotifyWhenNearMRTStationOnceManager {
    fileprivate init() {}
    
    static weak var shared: NotifyWhenNearMRTStationOnce! {
        get {
            var temp: NotifyWhenNearMRTStationOnce
            
            if sharedClosure == nil {
                temp = NotifyWhenNearMRTStationOnceImpl.shared
                sharedClosure = temp
            }
            
            return sharedClosure
        }
    }
    
    private static weak var sharedClosure: NotifyWhenNearMRTStationOnce?
}
