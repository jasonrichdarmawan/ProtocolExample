//
//  AlarmManager.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 26/07/23.
//

import Foundation

final class AlarmManager {
    static var isPlaying = false
    
    static var shared: Alarm! {
        get {
            if sharedClosure == nil {
                sharedClosure = AlarmImpl.shared
            }
            
            return sharedClosure
        }
        set {
            if newValue == nil {
                AlarmImpl.shared = nil
            }
            
            sharedClosure = newValue
        }
    }
    
    private static var sharedClosure: Alarm!
}
