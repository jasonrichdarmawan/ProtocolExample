//
//  DepartureArrivalView.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/07/23.
//

import SwiftUI

struct DepartureArrivalV1View<SelectVM: DepartureArrivalViewModel>: View {
    @ObservedObject var selectVM: SelectVM
    @Binding var selectedDetent: PresentationDetent
    
    init(
        selectVM: SelectVM = DepartureArrivalV1ViewModel(),
        selectedDetent: Binding<PresentationDetent> = .constant(.header)
    ) {
        self.selectVM = selectVM
        self._selectedDetent = selectedDetent
    }
    
    var body: some View {
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            GridRow {
                Circle()
                    .stroke(.blue, lineWidth: 4)
                    .frame(width: 16, height: 16)
                    .padding(.trailing, 16)
                
                DepartureOrArrivalButtonView(value: $selectVM.departure, selected: $selectVM.departureSelected, selectedDetent: $selectedDetent)
            }
            
            GridRow {
                Line()
                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [8,8]))
                    .foregroundColor(Color("departureArrival_line"))
                    .frame(width: 1, height: 24)
                    .padding(.trailing, 16)
                
                
            }
            
            GridRow {
                Circle()
                    .stroke(.blue, lineWidth: 4)
                    .frame(width: 16, height: 16)
                    .padding(.trailing, 16)
                
                DepartureOrArrivalButtonView(value: $selectVM.arrival, selected: $selectVM.arrivalSelected, selectedDetent: $selectedDetent)
            }
        }
    }
}

#if DEBUG
private struct DepartureArrivalViewExample<SelectVM: DepartureArrivalViewModel>: View {
    @StateObject private var selectVM: SelectVM
    
    init(selectVM: SelectVM = DepartureArrivalV1ViewModel()) {
        self._selectVM = StateObject(wrappedValue: selectVM)
    }
    
    var body: some View {
        VStack(spacing: 32) {
            DepartureArrivalV1View(selectVM: selectVM)
            
            VStack(spacing: 20) {
                Button {
                    withAnimation {
                        _ = selectVM.updateDepartureArrival(value: MRT.LebakBulusGrab.station)
                    }
                } label: {
                    Text("\(MRT.LebakBulusGrab.station.name) Station")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .font(.headline)
                .buttonStyle(.borderedProminent)
                
                Button {
                    withAnimation {
                        _ = selectVM.updateDepartureArrival(value: MRT.FatmawatiIndomaret.station)
                    }
                } label: {
                    Text("\(MRT.FatmawatiIndomaret.station.name) Station")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .font(.headline)
                .buttonStyle(.borderedProminent)
                
                Button {
                    withAnimation {
                        _ = selectVM.updateDepartureArrival(value: MRT.CipeteRaya.station)
                    }
                } label: {
                    Text("\(MRT.CipeteRaya.station.name) Station")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .font(.headline)
                .buttonStyle(.borderedProminent)
            }
            
            Spacer()
        }
        .padding(.top, 32)
        .padding(.horizontal, 32)
    }
}

struct DepartureArrivalViewExample_Previews: PreviewProvider {
    static var previews: some View {
        DepartureArrivalViewExample()
            .environment(\.locale, .init(identifier: "id-ID"))
    }
}
#endif
