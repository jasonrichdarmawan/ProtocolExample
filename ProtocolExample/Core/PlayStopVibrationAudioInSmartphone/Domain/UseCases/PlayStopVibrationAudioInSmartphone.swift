//
//  PlayStopVibrationSoundInSmartphone.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 26/07/23.
//

import Foundation

protocol PlayStopVibrationAudioInSmartphone {
    /// will play only vibration if app in muted mode
    func play() -> Bool
    func stop() -> Bool
}
