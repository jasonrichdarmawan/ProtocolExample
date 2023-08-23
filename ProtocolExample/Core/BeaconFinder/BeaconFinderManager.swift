//
//  BeaconFinderManager.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/08/23.
//

import Foundation

final class BeaconFinderManager {
    fileprivate init() {}
    
    static weak var shared: BeaconFinder! {
        get {
            var temp: BeaconFinder
            
            if sharedClosure == nil {
                temp = BeaconFinderImpl.shared
                sharedClosure = temp
            }
            
            return sharedClosure
        }
    }
    
    private static weak var sharedClosure: BeaconFinder?
}
