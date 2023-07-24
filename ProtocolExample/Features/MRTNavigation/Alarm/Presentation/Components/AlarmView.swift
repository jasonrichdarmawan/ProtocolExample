//
//  Alarm.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import SwiftUI

/// will play alarm for 1 second
struct AlarmView: View {
    @Binding private var isSoundOn: Bool {
        didSet {
            _ = useCase.play()
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.0, execute: {
                _ = useCase.stop()
            })
        }
    }
    
    private let useCase: AlarmManager
    
    init(isSoundOn: Binding<Bool>, useCase: AlarmManager = AlarmManagerImpl()) {
        self._isSoundOn = isSoundOn
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
private struct AlarmViewExample: View {
    @State private var isSoundOn = true
    
    var body: some View {
        AlarmView(isSoundOn: $isSoundOn)
    }
}

struct AlarmViewExample_Previews: PreviewProvider {
    static var previews: some View {
        AlarmViewExample()
    }
}
#endif
