//
//  NotifyWhenNearMRTStationWithGPSImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import Foundation

final class NotifyWhenNearMRTStationWithGPSImpl: NotifyWhenNearMRTStationWithGPS {
    weak var delegate: NotifyWhenNearMRTStationWithGPSDelegate?
    
    fileprivate init() {
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    deinit {
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    func start() -> NotifyWhenNearMRTStationWithGPSStartEvent {
        return .IS_STARTING
    }
    
    func stop() -> NotifyWhenNearMRTStationWithGPSStopEvent {
        return .IS_STOPPING
    }
}

extension NotifyWhenNearMRTStationWithGPSImpl {
    static weak var shared: NotifyWhenNearMRTStationWithGPS! {
        get {
            var temp: NotifyWhenNearMRTStationWithGPS
            
            if sharedClosure == nil {
                temp = NotifyWhenNearMRTStationWithGPSImpl()
                sharedClosure = temp
            }
            
            return sharedClosure
        }
    }
    
    private static weak var sharedClosure: NotifyWhenNearMRTStationWithGPS?
}
