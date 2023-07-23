//
//  BeaconFinderImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import CoreLocation

final class BeaconFinderImpl: BeaconFinder {
    var delegate: BeaconFinderDelegate?
    
    func isAuthorized() -> Bool {
        return true
    }
    
    func start(constraint: CLBeaconIdentityConstraint) -> BeaconFinderStartEvent {
        return .IS_STARTING
    }
    
    func stop() -> BeaconFinderStopEvent {
        return .IS_STOPPING
    }
}
