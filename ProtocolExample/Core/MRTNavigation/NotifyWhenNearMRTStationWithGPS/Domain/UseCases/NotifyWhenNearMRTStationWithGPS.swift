//
//  NotifyWhenNearMRTStationWithGPS.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/07/23.
//

import Foundation

protocol NotifyWhenNearMRTStationWithGPS {
    var delegate: NotifyWhenNearMRTStationWithGPSDelegate? { get set }
    
    func start() -> NotifyWhenNearMRTStationWithGPSStartEvent
    func stop() -> NotifyWhenNearMRTStationWithGPSStopEvent
}

protocol NotifyWhenNearMRTStationWithGPSDelegate {
    func notifyManager(_ manager: NotifyWhenNearMRTStationWithGPS, didFind: Station)
}

protocol NotifyWhenNearMRTStationWithGPSEvent {}

enum NotifyWhenNearMRTStationWithGPSStartEvent: NotifyWhenNearMRTStationWithGPSEvent { case IS_STARTING, NOT_AUTHORIZED }

enum NotifyWhenNearMRTStationWithGPSStopEvent: NotifyWhenNearMRTStationWithGPSEvent { case IS_STOPPING }
