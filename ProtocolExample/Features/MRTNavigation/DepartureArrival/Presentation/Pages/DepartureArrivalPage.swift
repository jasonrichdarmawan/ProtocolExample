//
//  DepartureArrivalV2Page.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 25/07/23.
//

import SwiftUI

struct DepartureArrivalPage: View {
    @StateObject private var viewModel: DepartureArrivalV2ViewModel
    
    init(viewModel: DepartureArrivalV2ViewModel = DepartureArrivalV2ViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            DepartureArrivalV2View(viewModel: viewModel)
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
