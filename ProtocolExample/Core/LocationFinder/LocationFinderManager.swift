//
//  LocationFinderManager.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 25/08/23.
//

import Foundation

final class LocationFinderManager {
    fileprivate init() {}
    
    static weak var shared: LocationFinder! {
        get {
            var temp: LocationFinder
            
            if sharedClosure == nil {
                temp = LocationFinderImpl.shared
                sharedClosure = temp
            }
            
            return sharedClosure
        }
    }
    
    private static weak var sharedClosure: LocationFinder?
}
