//
//  IsMutedModeManager.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/08/23.
//

import Foundation

final class IsMutedModeManager {
    static var isPlaying = false
    
    static var shared: IsMutedMode! {
        get {
            var temp: IsMutedMode
            
            if sharedClosure == nil {
                temp = IsMutedModeImpl.shared
                sharedClosure = temp
            }
            
            return sharedClosure
        }
    }
    
    private weak static var sharedClosure: IsMutedMode?
}
