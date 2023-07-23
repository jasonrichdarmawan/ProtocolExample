//
//  BeaconFinder.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import CoreLocation

protocol BeaconFinder {
    var delegate: BeaconFinderDelegate? { get set }
    
    func isAuthorized() -> Bool
    func start(constraint: CLBeaconIdentityConstraint) -> BeaconFinderStartEvent
    func stop() -> BeaconFinderStopEvent
}

protocol BeaconFinderDelegate {
    func notifyManager(_ manager: BeaconFinder, didRange: [CLBeaconIdentityConstraint : [CLBeacon]])
}

protocol BeaconFinderEvent {}

enum BeaconFinderStartEvent: BeaconFinderEvent { case IS_STARTING, NOT_AUTHORIZED }

enum BeaconFinderStopEvent: BeaconFinderEvent { case IS_STOPPING }
