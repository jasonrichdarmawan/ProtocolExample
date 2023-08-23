//
//  NotifyWhenNearMRTStationWhenInBackgroundManager.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/08/23.
//

import Foundation

final class NotifyWhenNearMRTStationWhenInBackgroundManager {
    fileprivate init() {}
    
    static weak var shared: NotifyWhenNearMRTStationWhenInBackground! {
        get {
            var temp: NotifyWhenNearMRTStationWhenInBackground
            
            if sharedClosure == nil {
                temp = NotifyWhenNearMRTStationWhenInBackgroundImpl.shared
                sharedClosure = temp
            }
            
            return sharedClosure
        }
    }
    
    static weak var sharedClosure: NotifyWhenNearMRTStationWhenInBackground?
}
