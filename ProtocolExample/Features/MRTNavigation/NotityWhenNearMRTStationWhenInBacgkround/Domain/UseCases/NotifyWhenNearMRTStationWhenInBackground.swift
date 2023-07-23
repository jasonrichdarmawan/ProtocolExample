//
//  NotifyWhenNearMRTStationWhenInBackground.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/07/23.
//

import Foundation

protocol NotifyWhenNearMRTStationWhenInBackground {
    func start() -> NotifyWhenNearMRTStationWhenInBackgroundStartEvent
    func stop() -> NotifyWhenNearMRTStationWhenInBackgroundStopEvent
}


protocol NotifyWhenNearMRTStationWhenInBackgroundDelegate {
    func notifyManager(_ manager: NotifyWhenNearMRTStationWhenInBackground, didFind: Station)
}

protocol NotifyWhenNearMRTStationWhenInBackgroundEvent {}

enum NotifyWhenNearMRTStationWhenInBackgroundStartEvent: NotifyWhenNearMRTStationWhenInBackgroundEvent { case IS_STARTING, NOT_AUTHORIZED }

enum NotifyWhenNearMRTStationWhenInBackgroundStopEvent: NotifyWhenNearMRTStationWhenInBackgroundEvent { case IS_STOPPING }
