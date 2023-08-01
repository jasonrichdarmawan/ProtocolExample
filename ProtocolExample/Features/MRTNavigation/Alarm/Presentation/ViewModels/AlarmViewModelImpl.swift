//
//  AlarmViewModel.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 26/07/23.
//

import Foundation

class AlarmViewModelImpl: AlarmViewModel {
    private var isMutedModeUseCase: IsMutedMode.Type
    private let playStopVibrationAudioInSmartphoneUseCase: PlayStopVibrationAudioInSmartphone
    
    @Published var isMutedMode: Bool {
        didSet {
            let _ = isMutedModeUseCase.set(value: isMutedMode)
            
            let _ = playStopVibrationAudioInSmartphoneUseCase.play()
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.0, execute: {
                let _ = self.playStopVibrationAudioInSmartphoneUseCase.stop()
            })
        }
    }
    
    init(
        isMutedModeUseCase: IsMutedMode.Type = IsMutedModeImpl.self,
        playStopVibrationAudioInSmartphoneUseCase: PlayStopVibrationAudioInSmartphone = PlayStopVibrationAudioInSmartphoneImpl()
    ) {
        self.isMutedModeUseCase = isMutedModeUseCase
        self.playStopVibrationAudioInSmartphoneUseCase = playStopVibrationAudioInSmartphoneUseCase
        
        self.isMutedMode = isMutedModeUseCase.get()
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
