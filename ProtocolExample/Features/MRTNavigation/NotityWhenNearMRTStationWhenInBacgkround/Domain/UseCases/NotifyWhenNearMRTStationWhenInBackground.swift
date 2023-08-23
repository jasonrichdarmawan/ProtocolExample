//
//  NotifyWhenNearMRTStationWhenInBackground.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/07/23.
//

import Foundation

protocol NotifyWhenNearMRTStationWhenInBackground: AnyObject {
    /// start finding when in background
    /// please handle applicationState in view, call stop() when enter foreground.
    func start() -> NotifyWhenNearMRTStationWhenInBackgroundStartEvent
    /// for abrupt stop
    func stop() -> NotifyWhenNearMRTStationWhenInBackgroundStopEvent
}


protocol NotifyWhenNearMRTStationWhenInBackgroundDelegate: AnyObject {
    func notifyManager(_ manager: NotifyWhenNearMRTStationWhenInBackground, didFind: Station)
}

protocol NotifyWhenNearMRTStationWhenInBackgroundEvent {}

enum NotifyWhenNearMRTStationWhenInBackgroundStartEvent: NotifyWhenNearMRTStationWhenInBackgroundEvent { case IS_STARTING, NOT_AUTHORIZED }

enum NotifyWhenNearMRTStationWhenInBackgroundStopEvent: NotifyWhenNearMRTStationWhenInBackgroundEvent { case IS_STOPPING }
