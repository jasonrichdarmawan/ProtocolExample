//
//  PlayStopVibrationAudioInSmartphoneManager.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/08/23.
//

import Foundation

final class PlayStopVibrationAudioInSmartphoneManager {
    fileprivate init() {}
    
    static weak var shared: PlayStopVibrationAudioInSmartphone! {
        get {
            var temp: PlayStopVibrationAudioInSmartphone
            
            if sharedClosure == nil {
                temp = PlayStopVibrationAudioInSmartphoneImpl.shared
                sharedClosure = temp
            }
            
            return sharedClosure
        }
    }
    
    private static weak var sharedClosure: PlayStopVibrationAudioInSmartphone?
}
