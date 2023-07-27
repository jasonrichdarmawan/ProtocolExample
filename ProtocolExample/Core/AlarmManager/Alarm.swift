//
//  AlarmManager.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import Foundation

protocol Alarm {
    /// will play vibration only continuosuly
    func playVibrationOnly() -> Bool
    
    /// will play vibration and audio continuously
    func playVibrationAndAudio() -> Bool
    
    /// for abrupt stop.
    func stop() -> Bool
}
