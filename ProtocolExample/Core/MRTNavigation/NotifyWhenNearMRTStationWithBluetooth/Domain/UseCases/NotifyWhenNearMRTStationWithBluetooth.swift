//
//  NotifyWhenNearMRTStationWithBluetooth.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/07/23.
//

import Foundation

protocol NotifyWhenNearMRTStationWithBluetooth {
    var delegate: NotifyWhenNearMRTStationWithBluetoothDelegate? { get set }
    
    func start() -> NotifyWhenNearMRTStationWithBluetoothStartEvent
    func stop() -> NotifyWhenNearMRTStationWithBluetoothStopEvent
}

protocol NotifyWhenNearMRTStationWithBluetoothDelegate {
    func notifyManager(_ manager: NotifyWhenNearMRTStationWithBluetooth, didFind: Station)
}

protocol NotifyWhenNearMRTStationWithBluetoothEvent {}

enum NotifyWhenNearMRTStationWithBluetoothStartEvent: NotifyWhenNearMRTStationWithBluetoothEvent { case IS_STARTING, NOT_AUTHORIZED }

enum NotifyWhenNearMRTStationWithBluetoothStopEvent: NotifyWhenNearMRTStationWhenInBackgroundEvent { case IS_STOPPING }
