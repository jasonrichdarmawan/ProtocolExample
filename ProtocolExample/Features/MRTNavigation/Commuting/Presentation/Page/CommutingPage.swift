//
//  CommutingPage.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 31/07/23.
//

import SwiftUI

struct CommutingPage<CommutingVM: CommutingPageViewModel>: View {
    @StateObject private var commutingVM: CommutingVM
    
    init(commutingVM: CommutingVM = CommutingPageViewModelImpl()) {
        self._commutingVM = StateObject(wrappedValue: commutingVM)
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
