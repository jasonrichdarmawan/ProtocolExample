//
//  DepartureArrivalV2Page.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 25/07/23.
//

import SwiftUI

struct DepartureArrivalPage: View {
    @StateObject private var viewModel: DepartureArrivalViewModel
    
    init(viewModel: DepartureArrivalViewModel = DepartureArrivalViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            DepartureArrivalView(viewModel: viewModel).padding(.top, 25)
            Spacer()
        }
        .padding(.horizontal, 32)
    }
}

#if DEBUG
struct DepartureArrivalPage_Preview: PreviewProvider {
    static var previews: some View {
        DepartureArrivalPage()
            .environment(\.locale, .init(identifier: "id-ID"))
    }
}
#endif
