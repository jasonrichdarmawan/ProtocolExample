//
//  Chevron.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import SwiftUI

struct ChevronView: View {
    @Binding private var isUp: Bool
    
    init(isUp: Binding<Bool>) {
        self._isUp = isUp
    }
    
    var body: some View {
        Button {
            isUp.toggle()
        } label: {
            Image(isUp ? "ChevronUp" : "ChevronDown")
        }
    }
}

#if DEBUG
private struct ChevronViewExample: View {
    @State private var isUp = "isUp"
    
    var body: some View {
        // simulate what if the parent variable is not Bool. i.e. PresentationDetent
        ChevronView(isUp: Binding(
            get: { isUp == "isUp" },
            set: { newValue in isUp = newValue ? "isUp" : "isDown" }
        ))
    }
}

struct ChevronView_Previews: PreviewProvider {
    static var previews: some View {
        ChevronViewExample()
    }
}
#endif
