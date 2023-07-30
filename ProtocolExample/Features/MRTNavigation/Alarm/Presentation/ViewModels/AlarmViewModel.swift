//
//  AlarmViewModel.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 26/07/23.
//

import Foundation

final class AlarmViewModel: ObservableObject {
    private var isMutedMode: IsMutedMode.Type
    private let playStopVibrationAudioInSmartphone: PlayStopVibrationAudioInSmartphone
    
    @Published var value: Bool {
        didSet {
            let _ = isMutedMode.set(value: value)
            
            let _ = playStopVibrationAudioInSmartphone.play()
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.0, execute: {
                let _ = self.playStopVibrationAudioInSmartphone.stop()
            })
        }
    }
    
    init(isMutedMode: IsMutedMode.Type = IsMutedModeImpl.self,
         playStopVibrationAudioInSmartphone: PlayStopVibrationAudioInSmartphone = PlayStopVibrationAudioInSmartphoneImpl()) {
        self.isMutedMode = isMutedMode
        self.playStopVibrationAudioInSmartphone = playStopVibrationAudioInSmartphone
        
        self.value = isMutedMode.get()
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    deinit {
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
}
