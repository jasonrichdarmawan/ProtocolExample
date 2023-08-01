//
//  NotifyWhenNearMRTStationAndSpecificMRTStationOnce.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import Foundation

protocol NotifyWhenNearMRTStationAndSpecificMRTStationOnce {
    var delegate: NotifyWhenNearMRTStationAndSpecificMRTStationOnceDelegate? { get set }
    
    /// will stop when found specific MRT station
    func start(arrival: Station) -> NotifyWhenNearMRTStationAndSpecificMRTStationOnceStartEvent
    /// for abrupt stop.
    func stop() -> NotifyWhenNearMRTStationAndSpecificMRTStationOnceStopEvent
}

enum NotifyWhenNearMRTStationAndSpecificMRTStationOnceDelegateEvent {
    case FOUND
    // will stop when arrived
    case ARRIVED
}

protocol NotifyWhenNearMRTStationAndSpecificMRTStationOnceDelegate {
    func notifyManager(_ manager: NotifyWhenNearMRTStationAndSpecificMRTStationOnce, didFind station: Station, didEvent event: NotifyWhenNearMRTStationAndSpecificMRTStationOnceDelegateEvent)
}

protocol NotifyWhenNearMRTStationAndSpecificMRTStationOnceEvent {}

enum NotifyWhenNearMRTStationAndSpecificMRTStationOnceStartEvent: NotifyWhenNearMRTStationAndSpecificMRTStationOnceEvent { case IS_STARTING, NOT_AUTHORIZED }

enum NotifyWhenNearMRTStationAndSpecificMRTStationOnceStopEvent: NotifyWhenNearMRTStationAndSpecificMRTStationOnceEvent { case IS_STOPPING }
