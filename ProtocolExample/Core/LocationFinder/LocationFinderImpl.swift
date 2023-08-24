//
//  LocationFinderImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import Foundation

final class LocationFinderImpl: LocationFinder {
    weak var delegate: LocationFinderDelegate?
    
    fileprivate init() {
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

extension LocationFinderImpl {
    static weak var shared: LocationFinder! {
        get {
            var temp: LocationFinder
            
            if sharedClosure == nil {
                temp = LocationFinderImpl()
                sharedClosure = temp
            }
            
            return sharedClosure
        }
    }
    
    private static weak var sharedClosure: LocationFinder?
}
