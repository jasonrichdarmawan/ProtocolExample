//
//  DepartureArrivalV2View.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 25/07/23.
//

import SwiftUI

struct DepartureArrivalV2View<ViewModel: DepartureArrivalViewModel>: View {
    @ObservedObject private var selectVM: ViewModel
    
    init(selectVM: ViewModel = DepartureArrivalV2ViewModel()) {
        self._selectVM = ObservedObject(wrappedValue: selectVM)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                DepartureV2View(value: $selectVM.departure, selected: $selectVM.departureSelected)
                Spacer()
                    .frame(width: 24, height: 24)
                    .padding(.leading, 16)
            }
            HStack(spacing: 0) {
                ArrivalV2View(value: $selectVM.arrival, selected: $selectVM.arrivalSelected)
                PlusCircleView()
                    .padding(.leading, 16)
            }
        }
    }
}

#if DEBUG
private struct DepartureArrivalV2ViewExample<ViewModel: DepartureArrivalViewModel>: View {
    @StateObject private var selectVM: ViewModel
    
    init(selectVM: ViewModel = DepartureArrivalV2ViewModel()) {
        self._selectVM = StateObject(wrappedValue: selectVM)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            DepartureArrivalV2View(selectVM: selectVM)
            
            VStack(alignment: .leading, spacing: 0) {
                Button("\(MRT.LebakBulusGrab.station.name) Station") {
                    _ = selectVM.updateDepartureArrival(value: MRT.LebakBulusGrab.station)
                }
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .padding(.vertical, 16)
                
                Button("\(MRT.FatmawatiIndomaret.station.name) Station") {
                    _ = selectVM.updateDepartureArrival(value: MRT.FatmawatiIndomaret.station)
                }
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .padding(.vertical, 16)
                
                Button("\(MRT.CipeteRaya.station.name) Station") {
                    _ = selectVM.updateDepartureArrival(value: MRT.CipeteRaya.station)
                }
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .padding(.vertical, 16)
            }
            
            Spacer()
        }
        .padding(.horizontal, 32)
    }
}

struct DepartureArrivalV2View_Previews: PreviewProvider {
    static var previews: some View {
        DepartureArrivalV2ViewExample()
            .environment(\.locale, .init(identifier: "id-ID"))
    }
}
#endif
