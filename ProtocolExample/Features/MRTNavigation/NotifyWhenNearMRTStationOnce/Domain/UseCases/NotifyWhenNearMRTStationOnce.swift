//
//  NotifyWhenNearMRTStationOnce.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/07/23.
//

import Foundation

protocol NotifyWhenNearMRTStationOnce {
    var delegate: NotifyWhenNearMRTStationOnceDelegate? { get set }
    
    /// will stop after found any MRT station or after 3 seconds.
    func start() -> NotifyWhenNearMRTStationOnceStartEvent
    /// for abrupt stop.
    func stop() -> NotifyWhenNearMRTStationOnceStopEvent
}

enum NotifyWhenNearMRTStationOnceDelegateEvent { case TIME_OUT, FOUND }

protocol NotifyWhenNearMRTStationOnceDelegate {
    func notifyManager(_ manager: NotifyWhenNearMRTStationOnce, didFind station: Station, didEvent event: NotifyWhenNearMRTStationOnceDelegateEvent)
    func notifyManager(_ manager: NotifyWhenNearMRTStationOnce, didEvent event: NotifyWhenNearMRTStationOnceDelegateEvent)
}

protocol NotifyWhenNearMRTStationOnceEvent {}

enum NotifyWhenNearMRTStationOnceStartEvent: NotifyWhenNearMRTStationOnceEvent { case IS_STARTING, NOT_AUTHORIZED }

enum NotifyWhenNearMRTStationOnceStopEvent: NotifyWhenNearMRTStationOnceEvent { case IS_STOPPING }
