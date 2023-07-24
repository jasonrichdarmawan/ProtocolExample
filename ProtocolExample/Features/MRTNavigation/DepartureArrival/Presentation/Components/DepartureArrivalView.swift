//
//  DepartureArrivalView.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/07/23.
//

import SwiftUI

struct DepartureArrivalView: View {
    @Binding var value: Station
    @Binding var selected: Bool
    
    var body: some View {
        Button {
            selected = true
        } label: {
            Text("\(value.name) Station")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title2)
        }
        .selectedButtonStyle(selected)
        .padding(16)
    }
}

#if DEBUG
private final class DepartureArrivalViewModel_Example: ObservableObject {
    @Published var departure: Station
    @Published var arrival: Station
    
    @Published var departureSelected: Bool
    var arrivalSelected: Bool {
        get {
            return !departureSelected
        }
        set {
            departureSelected = !newValue
        }
    }
    
    init(departure: Station = MRT.LebakBulusGrab.station, arrival: Station = MRT.DukuhAtasBNI.station, departureSelected: Bool = false) {
        self.departure = departure
        self.arrival = arrival
        self.departureSelected = departureSelected
    }
    
    func updateDepartureArrival(value: Station) {
        if departureSelected {
            departure = value
        } else {
            arrival = value
        }
    }
}

private struct DepartureArrivalViewExample: View {
    @StateObject private var viewModel = DepartureArrivalViewModel_Example()
    
    var body: some View {
        VStack(spacing: 0) {
            DepartureArrivalView(value: $viewModel.departure, selected: $viewModel.departureSelected)
            DepartureArrivalView(value: $viewModel.arrival, selected: $viewModel.arrivalSelected)
            
            VStack(alignment: .leading, spacing: 0) {
                Button("\(MRT.LebakBulusGrab.station.name) Station") {
                    viewModel.updateDepartureArrival(value: MRT.LebakBulusGrab.station)
                }
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .padding(.vertical, 16)
                
                Button("\(MRT.FatmawatiIndomaret.station.name) Station") {
                    viewModel.updateDepartureArrival(value: MRT.FatmawatiIndomaret.station)
                }
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .padding(.vertical, 16)
            }
            
            Spacer()
        }
    }
}

struct DepartureArrivalViewExample_Previews: PreviewProvider {
    static var previews: some View {
        DepartureArrivalViewExample()
            .environment(\.locale, .init(identifier: "id-ID"))
    }
}
#endif
