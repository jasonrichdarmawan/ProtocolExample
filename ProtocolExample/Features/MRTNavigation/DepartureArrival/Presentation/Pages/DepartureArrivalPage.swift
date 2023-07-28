//
//  DepartureArrivalV2Page.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 25/07/23.
//

import SwiftUI

struct DepartureArrivalPage<DepartureArrivalVM>: View where DepartureArrivalVM: DepartureArrivalViewModel {
    @StateObject private var departureArrivalPageViewModel: DepartureArrivalPageViewModel
    
    @StateObject private var departureArrivalViewModel: DepartureArrivalVM
    @StateObject private var nextScheduleEstimatedTimeArrivalViewModel: NextScheduleEstimatedTimeArrivalViewModel

    init(
        departureArrivalPageViewModel: DepartureArrivalPageViewModel = DepartureArrivalPageViewModel(),
        departureArrivalViewModel: DepartureArrivalVM = DepartureArrivalV1ViewModel(),
        nextScheduleEstimatedtimeArrivalViewModel: NextScheduleEstimatedTimeArrivalViewModel = NextScheduleEstimatedTimeArrivalViewModel()
    ) {
        self._departureArrivalPageViewModel = StateObject(wrappedValue: departureArrivalPageViewModel)
        self._departureArrivalViewModel = StateObject(wrappedValue: departureArrivalViewModel)
        self._nextScheduleEstimatedTimeArrivalViewModel = StateObject(wrappedValue: nextScheduleEstimatedtimeArrivalViewModel)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Where to go today?")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color("departureArrival_text_active"))
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(32)
        .background(.blue)
        // TODO: use custom sheet
        // sheet prevent swipe back gesture
        .sheet(isPresented: $departureArrivalPageViewModel.isPresented) {
            VStack(spacing: 32) {
                DepartureArrivalV1View(viewModel: departureArrivalViewModel, selectedDetent: $departureArrivalPageViewModel.selection)

                switch departureArrivalPageViewModel.selection {
                case .header:
                    NextScheduleEstimatedTimeArrivalView(viewModel: nextScheduleEstimatedTimeArrivalViewModel)

                    Spacer()

                    Button {
                        departureArrivalPageViewModel.isPresented = false
                    } label: {
                        Text("Start")
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(departureArrivalViewModel.isDepartureArrivalNotNil() ? false : true)
                case .large:
                    SelectMRTStationView(value: departureArrivalViewModel.currentSelected, selectedDetent: $departureArrivalPageViewModel.selection)
                default:
                    EmptyView()
                }
            }
            .padding(.top, 32)
            .padding(.horizontal, 32)
            .presentationDetents([.header, .large], selection: $departureArrivalPageViewModel.selection)
            .interactiveDismissDisabled(true)
            .presentationDragIndicator(.hidden)
            .presentationBackgroundInteraction(.enabled)
        }
        .navigationDestination(
            isPresented: $departureArrivalPageViewModel.presentCommutingView,
            destination: {
                NavigationLazyView {
                    Text("CommutingView")
                }
                .navigationBarBackButtonHidden(true)
            }
        )
    }
}

#if DEBUG
struct DepartureArrivalPage_Preview: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DepartureArrivalPage()
                .environment(\.locale, .init(identifier: "id-ID"))
        }
    }
}
#endif
