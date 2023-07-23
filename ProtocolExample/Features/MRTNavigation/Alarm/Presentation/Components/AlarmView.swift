//
//  Alarm.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import SwiftUI

/// will play alarm for 1 second
struct AlarmView: View {
    @State private var isSoundOn: Bool {
        didSet {
            _ = useCase.play()
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.0, execute: {
                _ = useCase.stop()
            })
        }
    }
    
    private let useCase: AlarmManager
    
    init(isSoundOn: Bool, useCase: AlarmManager = AlarmManagerImpl()) {
        self._isSoundOn = State(wrappedValue: isSoundOn)
        self.useCase = useCase
    }
    
    var body: some View {
        Button {
            isSoundOn.toggle()
        } label: {
            Image(isSoundOn ? "SoundOn" : "SoundOff")
        }
    }
}

#if DEBUG
struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView(isSoundOn: true)
    }
}
#endif
