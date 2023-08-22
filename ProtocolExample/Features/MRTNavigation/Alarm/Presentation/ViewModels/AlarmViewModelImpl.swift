//
//  AlarmViewModel.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 26/07/23.
//

import Foundation

class AlarmViewModelImpl: AlarmViewModel {
    private var isMutedModeUseCase: IsMutedMode
    private let feedbackUseCase: PlayStopVibrationAudioInSmartphone
    
    @Published var isMutedMode: Bool {
        didSet {
            let _ = isMutedModeUseCase.set(value: isMutedMode)
            
            let _ = feedbackUseCase.play()
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.0, execute: {
                let _ = self.feedbackUseCase.stop()
            })
        }
    }
    
    init(
        isMutedModeUseCase: IsMutedMode = IsMutedModeManager.shared,
        feedbackUseCase: PlayStopVibrationAudioInSmartphone = PlayStopVibrationAudioInSmartphoneImpl()
    ) {
        self.isMutedModeUseCase = isMutedModeUseCase
        self.feedbackUseCase = feedbackUseCase
        
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
