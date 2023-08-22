//
//  AlarmManager.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 26/07/23.
//

import Foundation

final class AlarmManager {
    static var isPlaying = false
    
    static weak var shared: Alarm! {
        get {
            var temp: Alarm
            
            if sharedClosure == nil {
                temp = AlarmImpl.shared
                sharedClosure = temp
            }
            
            return sharedClosure
        }
    }
    
    private weak static var sharedClosure: Alarm?
}
