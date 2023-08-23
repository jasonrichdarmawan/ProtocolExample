//
//  AlarmViewModel.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 26/07/23.
//

import Foundation

class AlarmViewModelImpl: AlarmViewModel {
    private let isMutedModeUseCase: IsMutedMode
    private let feedbackUseCase: PlayStopVibrationAudioInSmartphone
    
    @Published var isMutedMode: Bool {
        didSet {
            let _ = isMutedModeUseCase.set(value: isMutedMode)
            
            let _ = feedbackUseCase.play()
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.0, execute: { [weak self] in
                let _ = self?.feedbackUseCase.stop()
            })
        }
    }
    
    init(
        isMutedModeUseCase: IsMutedMode = IsMutedModeManager.shared,
        feedbackUseCase: PlayStopVibrationAudioInSmartphone = PlayStopVibrationAudioInSmartphoneManager.shared
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
