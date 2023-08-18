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
    @ObservedObject var departureArrivalSelectVM: SelectVM
    
    init(departureArrivalSelectVM: SelectVM = DepartureArrivalViewModelImpl(arrival: MRT.CipeteRaya.station)) {
        self.departureArrivalSelectVM = departureArrivalSelectVM
    }
    
    var body: some View {
        VStack {
            Button {
                departureArrivalSelectVM.departureSelected = true
            } label: {
                Text((departureArrivalSelectVM.departure != nil) ? "\(departureArrivalSelectVM.departure?.name ?? "") Station" : "Where to?")
            }
            
            Button {
                departureArrivalSelectVM.arrivalSelected = true
            } label: {
                Text((departureArrivalSelectVM.arrival != nil) ? "\(departureArrivalSelectVM.arrival?.name ?? "") Station" : "Where to?")
            }
            
            SelectMRTStationView(
                value: departureArrivalSelectVM.currentSelected,
                currentDepartureValue: $departureArrivalSelectVM.departure,
                currentArrivalValue: $departureArrivalSelectVM.arrival
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
