//
//  Alarm.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import SwiftUI

/// will play alarm for 1 second
struct AlarmView: View {
    @ObservedObject private var viewModel: AlarmViewModel
    
    init(viewModel: AlarmViewModel = AlarmViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Button {
            viewModel.value.toggle()
        } label: {
            Image(viewModel.value ? "SoundOff" : "SoundOn")
        }
    }
}

#if DEBUG
private struct AlarmViewExample: View {
    @State private var isSoundOn = true
    
    var body: some View {
        AlarmView()
    }
}

struct AlarmViewExample_Previews: PreviewProvider {
    static var previews: some View {
        AlarmViewExample()
    }
}
#endif
