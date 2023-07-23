//
//  NotifyWhenNearMRTStationWithGPSImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import Foundation

final class NotifyWhenNearMRTStationWithGPSImpl: NotifyWhenNearMRTStationWithGPS {
    var delegate: NotifyWhenNearMRTStationWithGPSDelegate?
    
    func start() -> NotifyWhenNearMRTStationWithGPSStartEvent {
        return .IS_STARTING
    }
    
    func stop() -> NotifyWhenNearMRTStationWithGPSStopEvent {
        return .IS_STOPPING
    }
}
