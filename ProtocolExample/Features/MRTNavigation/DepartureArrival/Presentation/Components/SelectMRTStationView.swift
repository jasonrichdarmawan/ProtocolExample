//
//  ListOfMRTStationView.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 28/07/23.
//

import SwiftUI

struct SelectMRTStationView: View {
    @Binding var value: Station?
    
    init(value: Binding<Station?> = .constant(nil)) {
        self._value = value
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(MRT.stations) { station in
                    Button {
                        withAnimation {
                            value = station
                        }
                    } label: {
                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundColor(Color("departureArrival_button_active"))
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
private struct SelectMRTStationViewExample<DepartureArrivalVM>: View where DepartureArrivalVM: DepartureArrivalViewModel {
    @ObservedObject var alarmVM: DepartureArrivalVM
    
    init(alarmVM: DepartureArrivalVM = DepartureArrivalV1ViewModel()) {
        self.alarmVM = alarmVM
    }
    
    var body: some View {
        VStack {
            Button {
                alarmVM.departureSelected = true
            } label: {
                Text((alarmVM.departure != nil) ? "\(alarmVM.departure?.name ?? "") Station" : "Where to?")
            }
            
            Button {
                alarmVM.arrivalSelected = true
            } label: {
                Text((alarmVM.arrival != nil) ? "\(alarmVM.arrival?.name ?? "") Station" : "Where to?")
            }
            
            SelectMRTStationView(value: alarmVM.currentSelected)
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
