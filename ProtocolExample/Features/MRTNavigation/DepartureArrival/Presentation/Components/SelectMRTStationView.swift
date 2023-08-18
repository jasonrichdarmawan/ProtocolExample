//
//  ListOfMRTStationView.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 28/07/23.
//

import SwiftUI

struct SelectMRTStationView: View {
    @Binding var value: Station?
    @Binding var currentDepartureValue: Station?
    @Binding var currentArrivalValue: Station?
    @Binding var isPresented: Bool
    
    init(
        value: Binding<Station?> = .constant(nil),
        currentDepartureValue: Binding<Station?> = .constant(nil),
        currentArrivalValue: Binding<Station?> = .constant(nil),
        isPresented: Binding<Bool> = .constant(false)
    ) {
        self._value = value
        self._currentArrivalValue = currentArrivalValue
        self._currentDepartureValue = currentDepartureValue
        self._isPresented = isPresented
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(MRT.stations) { station in
                    Button {
                        withAnimation {
                            value = station
                            isPresented = false
                        }
                    } label: {
                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundColor(station == value ? Color("departureArrival_button_active") : Color("departureArrival_button_inactive"))
                        Text("\(station.name) Station")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(station.acronym)
                    }
                    .padding(8)
                }
            }
        }
    }
}

#if DEBUG
private struct SelectMRTStationViewExample<SelectVM: DepartureArrivalViewModel>: View {
    @ObservedObject var selectVM: SelectVM
    
    init(selectVM: SelectVM = DepartureArrivalViewModelImpl(arrival: MRT.CipeteRaya.station)) {
        self.selectVM = selectVM
    }
    
    var body: some View {
        VStack {
            Button {
                selectVM.departureSelected = true
            } label: {
                Text((selectVM.departure != nil) ? "\(selectVM.departure?.name ?? "") Station" : "Where to?")
            }
            
            Button {
                selectVM.arrivalSelected = true
            } label: {
                Text((selectVM.arrival != nil) ? "\(selectVM.arrival?.name ?? "") Station" : "Where to?")
            }
            
            SelectMRTStationView(
                value: selectVM.currentSelected,
                currentDepartureValue: $selectVM.departure,
                currentArrivalValue: $selectVM.arrival
            )
        }
    }
}

struct SelectMRTStationView_Previews: PreviewProvider {
    static var previews: some View {
        SelectMRTStationViewExample()
            .environment(\.locale, .init(identifier: "id-ID"))
    }
}
#endif
