//
//  DepartureArrivalView.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/07/23.
//

import SwiftUI

struct DepartureArrivalView: View {
    @Binding var value: String
    @Binding var selected: Bool
    
    var body: some View {
        Button {
            selected = true
        } label: {
            Text(value)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title2)
        }
        .selectedButtonStyle(selected)
        .padding(16)
    }
}

#if DEBUG
private final class DepartureArrivalViewModel_Example: ObservableObject {
    @Published var departure: String
    @Published var arrival: String
    
    @Published var departureSelected: Bool
    var arrivalSelected: Bool {
        get {
            return !departureSelected
        }
        set {
            departureSelected = !newValue
        }
    }
    
    init(departure: String = "Departure", arrival: String = "Arrival", departureSelected: Bool = false) {
        self.departure = departure
        self.arrival = arrival
        self.departureSelected = departureSelected
    }
    
    func updateDepartureArrival(value: String) {
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
                Button("Stasiun Lebak Bulus Grab") {
                    viewModel.updateDepartureArrival(value: "Stasiun Lebak Bulus Grab")
                }
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .padding(.vertical, 16)
                
                Button("Stasiun Fatmawati Indomaret") {
                    viewModel.updateDepartureArrival(value: "Stasiun Fatmawati Indomaret")
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
    }
}
#endif
