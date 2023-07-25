//
//  AlarmManager.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import Foundation

protocol Alarm {
    /// will play haptic and audio feedback continuously
    func play() -> Bool
    /// for abrupt stop.
    func stop() -> Bool
}
