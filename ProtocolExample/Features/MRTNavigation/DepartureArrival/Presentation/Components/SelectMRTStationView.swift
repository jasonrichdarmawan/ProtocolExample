//
//  ListOfMRTStationView.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 28/07/23.
//

import SwiftUI

struct SelectMRTStationView: View {
    @Binding var value: Station?
    @Binding var selectedDetent: PresentationDetent
    
    init(value: Binding<Station?> = .constant(nil), selectedDetent: Binding<PresentationDetent> = .constant(.header)) {
        self._value = value
        self._selectedDetent = selectedDetent
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(MRT.stations) { station in
                    Button {
                        withAnimation {
                            value = station
                            selectedDetent = .header
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
    @ObservedObject var viewModel: DepartureArrivalVM
    
    init(viewModel: DepartureArrivalVM = DepartureArrivalV1ViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Button {
                viewModel.departureSelected = true
            } label: {
                Text((viewModel.departure != nil) ? "\(viewModel.departure?.name ?? "") Station" : "Where to?")
            }
            
            Button {
                viewModel.arrivalSelected = true
            } label: {
                Text((viewModel.arrival != nil) ? "\(viewModel.arrival?.name ?? "") Station" : "Where to?")
            }
            
            SelectMRTStationView(value: viewModel.currentSelected)
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
