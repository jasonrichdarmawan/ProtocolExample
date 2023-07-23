//
//  NotifyWhenNearMRTStationOnce.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/07/23.
//

import Foundation

protocol NotifyWhenNearMRTStationOnce {
    var delegate: NotifyWhenNearMRTStationOnceDelegate? { get set }
    
    func start() -> NotifyWhenNearMRTStationOnceStartEvent
    func stop() -> NotifyWhenNearMRTStationOnceStopEvent
}


protocol NotifyWhenNearMRTStationOnceDelegate {
    func notifyManager(_ manager: NotifyWhenNearMRTStationOnce, didFind station: Station)
}

protocol NotifyWhenNearMRTStationOnceEvent {}

enum NotifyWhenNearMRTStationOnceStartEvent: NotifyWhenNearMRTStationOnceEvent { case IS_STARTING, NOT_AUTHORIZED }

enum NotifyWhenNearMRTStationOnceStopEvent: NotifyWhenNearMRTStationOnceEvent { case IS_STOPPING }
