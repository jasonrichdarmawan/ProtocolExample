//
//  Alarm.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import SwiftUI

/// will play alarm for 1 second
struct AlarmView<AlarmVM: AlarmViewModel>: View {
    @ObservedObject private var alarmVM: AlarmVM
    
    init(alarVM: AlarmVM = AlarmViewModelImpl()) {
        self.alarmVM = alarVM
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    var body: some View {
        Button {
            alarmVM.isMutedMode.toggle()
        } label: {
            Image(alarmVM.isMutedMode ? "SoundOff" : "SoundOn")
        }
    }
}

#if DEBUG
struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView()
    }
}
#endif
