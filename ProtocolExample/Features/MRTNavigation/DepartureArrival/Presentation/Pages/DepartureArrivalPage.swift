//
//  DepartureArrivalV2Page.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 25/07/23.
//

import SwiftUI

struct DepartureArrivalPage: View {
    @StateObject private var departureArrivalViewModel: DepartureArrivalViewModel
    @StateObject private var nextScheduleEstimatedTimeArrivalViewModel: NextScheduleEstimatedTimeArrivalViewModel
    
    init(
        departureArrivalViewModel: DepartureArrivalViewModel = DepartureArrivalViewModel(),
        nextScheduleEstimatedtimeArrivalViewModel: NextScheduleEstimatedTimeArrivalViewModel = NextScheduleEstimatedTimeArrivalViewModel()
    ) {
        self._departureArrivalViewModel = StateObject(wrappedValue: departureArrivalViewModel)
        self._nextScheduleEstimatedTimeArrivalViewModel = StateObject(wrappedValue: nextScheduleEstimatedtimeArrivalViewModel)
    }
    
    var body: some View {
        VStack(spacing: 32) {
            DepartureArrivalView(viewModel: departureArrivalViewModel)
            
            NextScheduleEstimatedTimeArrivalView(viewModel: nextScheduleEstimatedTimeArrivalViewModel)
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Start")
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(departureArrivalViewModel.isDepartureArrivalNotNil() ? false : true)
        }
        .padding(.top, 25)
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
