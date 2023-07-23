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
final class DepartureArrivalViewModel_Example: ObservableObject {
    @Published var departure = "Departure"
    @Published var arrival = "Arrival"
    @Published var departureSelected = false
    
    func updateDepartureArrival(value: String) {
        if departureSelected {
            departure = value
        } else {
            arrival = value
        }
    }
}

struct DepartureArrivalView_Example: View {
    @StateObject private var viewModel = DepartureArrivalViewModel_Example()
    
    var body: some View {
        VStack(spacing: 0) {
            DepartureArrivalView(value: $viewModel.departure, selected: $viewModel.departureSelected)
            DepartureArrivalView(
                value: $viewModel.arrival,
                selected: Binding(
                    get: { return !viewModel.departureSelected },
                    set: { newValue in viewModel.departureSelected = !newValue }))
            
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
        DepartureArrivalView_Example()
    }
}
#endif
