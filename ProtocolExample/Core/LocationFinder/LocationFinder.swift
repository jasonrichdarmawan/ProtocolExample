//
//  LocationFinder.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import Foundation
import CoreLocation

protocol LocationFinder {
    var delegate: LocationFinderDelegate? { get set }
    
    /// please show alert in view if return false
    func isAuthorizedAlwaysOrRequestAuthorization() -> Bool
    func start() -> LocationFinderStartEvent
    func stop() -> LocationFinderStopEvent
}

protocol LocationFinderDelegate {
    func notifyManager(_ manager: LocationFinder, didUpdateTo: CLLocation)
}

protocol LocationFinderEvent {}

enum LocationFinderStartEvent: LocationFinderEvent { case IS_STARTING, NOT_AUTHORIZED }

enum LocationFinderStopEvent: LocationFinderEvent { case IS_STOPPING }
