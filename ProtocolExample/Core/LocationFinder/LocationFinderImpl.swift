//
//  LocationFinderImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import Foundation

final class LocationFinderImpl: LocationFinder {
    var delegate: LocationFinderDelegate?
    
    init() {
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    deinit {
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    func isAuthorizedAlwaysOrRequestAuthorization() -> Bool {
        return true
    }
    
    func start() -> LocationFinderStartEvent {
        return .IS_STARTING
    }
    
    func stop() -> LocationFinderStopEvent {
        return .IS_STOPPING
    }
}
