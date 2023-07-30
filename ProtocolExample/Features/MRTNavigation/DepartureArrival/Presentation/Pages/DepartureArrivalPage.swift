//
//  DepartureArrivalV2Page.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 25/07/23.
//

import SwiftUI

struct DepartureArrivalPage: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var pageVM: DepartureArrivalPageViewModel
    
    @StateObject private var selectVM: DepartureArrivalViewModelImpl
    @StateObject private var scheduleVM: NextScheduleEstimatedTimeArrivalViewModel

    init(
        pageVM: DepartureArrivalPageViewModel = DepartureArrivalPageViewModel(),
        selectVM: DepartureArrivalViewModelImpl = DepartureArrivalV1ViewModel(),
        scheduleVM: NextScheduleEstimatedTimeArrivalViewModel = NextScheduleEstimatedTimeArrivalViewModel()
    ) {
        self._pageVM = StateObject(wrappedValue: pageVM)
        self._selectVM = StateObject(wrappedValue: selectVM)
        self._scheduleVM = StateObject(wrappedValue: scheduleVM)
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
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
        .sheet(
            isPresented: $pageVM.presentSheet,
            onDismiss: { _ = pageVM.sheetDidDismiss(dismiss) }
        ) {
            VStack(spacing: 32) {
                DepartureArrivalV1View(selectVM: selectVM, selectedDetent: $pageVM.selectedDetent)

                switch pageVM.selectedDetent {
                case .header:
                    NextScheduleEstimatedTimeArrivalView(scheduleVM: scheduleVM)

                    Spacer()

                    Button {
                        pageVM.presentNavigationDestination = true
                    } label: {
                        Text("Start")
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(selectVM.isDepartureArrivalNotNil() ? false : true)
                case .large:
                    SelectMRTStationView(value: selectVM.currentSelected, selectedDetent: $pageVM.selectedDetent)
                default:
                    EmptyView()
                }
            }
            .padding(.top, 32)
            .padding(.horizontal, 32)
            .presentationDetents([.header])
            .presentationBackgroundInteraction(.enabled(upThrough: .header))
        }
        .navigationDestination(
            isPresented: $pageVM.presentNavigationDestination,
            destination: {
                NavigationLazyView {
                    CommutingPage()
                }
                .navigationBarBackButtonHidden(true)
                .onDisappear { _ = pageVM.navigationDestinationDidDisappear()}
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
