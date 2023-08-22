//
//  PlayStopVibrationSoundInSmartphoneImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 26/07/23.
//

import Foundation

final class PlayStopVibrationAudioInSmartphoneImpl: PlayStopVibrationAudioInSmartphone {
    private var alarm: Alarm
    private var isMutedMode: IsMutedMode
    
    init(
        alarm: Alarm = AlarmManager.shared,
        isMutedMode: IsMutedMode = IsMutedModeManager.shared) {
        self.alarm = alarm
        self.isMutedMode = isMutedMode
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    deinit {
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    func play() -> Bool {
        switch isMutedMode.get() {
        case true:
            return alarm.playVibrationOnly()
        case false:
            return alarm.playVibrationAndAudio()
        }
    }
    
    func stop() -> Bool {
        return alarm.stop()
    }
}
