//
//  CommutingPage.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 31/07/23.
//

import SwiftUI

struct CommutingPage: View {
    @StateObject private var pageVM: CommutingPageViewModel
    
    init(pageVM: CommutingPageViewModel = CommutingPageViewModel()) {
        self._pageVM = StateObject(wrappedValue: pageVM)
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    var body: some View {
        VStack {
            Text("CommutingPage")
        }
    }
}
