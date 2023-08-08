//
//  ListOfMRTStationView.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 28/07/23.
//

import SwiftUI

struct SelectMRTStationView: View {
    @Binding var value: Station?
    @Binding var isPresented: Bool
    
    init(value: Binding<Station?> = .constant(nil), isPresented: Binding<Bool> = .constant(false)) {
        self._value = value
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
private struct SelectMRTStationViewExample<SelectVM: DepartureArrivalViewModel>: View {
    @ObservedObject var selectVM: SelectVM
    
    init(selectVM: SelectVM = DepartureArrivalViewModelImpl()) {
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
            
            SelectMRTStationView(value: selectVM.currentSelected)
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
