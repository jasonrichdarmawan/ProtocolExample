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
    ScheduleVM: DepartureArrivalScheduleViewModel
>: ViewControllable {
    @ObservedObject var sheetVM: SheetVM
    @ObservedObject var selectVM: SelectVM
    @ObservedObject var scheduleVM: ScheduleVM
    
    init(
        sheetVM: SheetVM,
        selectVM: SelectVM = DepartureArrivalViewModelImpl(),
        scheduleVM: ScheduleVM = DepartureArrivalScheduleViewModelImpl()
    ) {
        self.sheetVM = sheetVM
        self.selectVM = selectVM
        self.scheduleVM = scheduleVM
    }
    
    var body: some View {
        VStack(spacing: 32) {
            DepartureArrivalV1View(selectVM: selectVM, isSelectMRTStationPresented: $sheetVM.isPresented)
            
            if !sheetVM.isPresented {
                DepartureArrivalScheduleView(scheduleVM: scheduleVM)
                
                Spacer()

                Button {
                    _ = sheetVM.nextPage()
                } label: {
                    Text("Start")
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(selectVM.isDepartureArrivalNotNil() ? false : true)
            } else {
                SelectMRTStationView(value: selectVM.currentSelected, isPresented: $sheetVM.isPresented)
            }
        }
        .padding(.top, 32)
        .padding(.horizontal, 32)
    }
}
