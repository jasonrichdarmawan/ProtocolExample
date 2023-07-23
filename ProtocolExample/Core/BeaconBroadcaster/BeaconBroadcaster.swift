//
//  BeaconBroadcaster.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import Foundation

protocol BeaconBroadcaster {
    func isAuthorizedOrRequestAuthorization() -> Bool
    func start(uuid: UUID, major: UInt16, minor: UInt16) -> BeaconBroadcasterStartEvent
    func stop() -> BeaconBroadcasterStopEvent
}

protocol BeaconBroadcasterEvent {}

enum BeaconBroadcasterStartEvent: BeaconBroadcasterEvent { case IS_STARTING, NOT_AUTHORIZED }

enum BeaconBroadcasterStopEvent: BeaconBroadcasterEvent { case IS_STOPPING }
