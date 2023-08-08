//
//  DepartureArrivalSheet.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

struct DepartureArrivalSheet<
    SheetVM: DepartureArrivalSheetViewModel,
    SelectVM: DepartureArrivalViewModel,
    ScheduleVM: ScheduleViewModel
>: ViewControllable {
    private var coordinator: Coordinator
    
    @ObservedObject var sheetVM: SheetVM
    @ObservedObject var selectVM: SelectVM
    @ObservedObject var scheduleVM: ScheduleVM
    
    init(
        coordinator: Coordinator,
        sheetVM: SheetVM,
        selectVM: SelectVM = DepartureArrivalViewModelImpl(),
        scheduleVM: ScheduleVM = ScheduleViewModelImpl()
    ) {
        self.coordinator = coordinator
        self.sheetVM = sheetVM
        self.selectVM = selectVM
        self.scheduleVM = scheduleVM
    }
    
    var body: some View {
        VStack(spacing: 32) {
            DepartureArrivalV1View(selectVM: selectVM, isSelectMRTStationPresented: $sheetVM.isSelectMRTStationPresented)
            
            if !sheetVM.isSelectMRTStationPresented {
                ScheduleView(scheduleVM: scheduleVM)
                
                Spacer()

                Button {
                    _ = coordinator.showRoute(MRTNavigationRoute.CommutingPage)
                } label: {
                    Text("Start")
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(selectVM.isDepartureArrivalNotNil() ? false : true)
            } else {
                SelectMRTStationView(value: selectVM.currentSelected, isPresented: $sheetVM.isSelectMRTStationPresented)
            }
        }
        .padding(.top, 32)
        .padding(.horizontal, 32)
    }
}
