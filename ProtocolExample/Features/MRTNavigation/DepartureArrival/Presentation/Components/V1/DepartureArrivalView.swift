//
//  DepartureArrivalView.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/07/23.
//

import SwiftUI

struct DepartureArrivalView: View {
    @ObservedObject private var viewModel: DepartureArrivalViewModel
    
    init(viewModel: DepartureArrivalViewModel = DepartureArrivalViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group {
            DepartureOrArrivalButtonView(value: $viewModel.departure, selected: $viewModel.departureSelected)
            DepartureOrArrivalButtonView(value: $viewModel.arrival, selected: $viewModel.arrivalSelected)
        }
    }
}

#if DEBUG
private struct DepartureArrivalViewExample: View {
    @StateObject private var viewModel: DepartureArrivalViewModel
    
    init(viewModel: DepartureArrivalViewModel = DepartureArrivalViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            DepartureArrivalView(viewModel: viewModel)
            
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
                
                Button("\(MRT.CipeteRaya.station.name) Station") {
                    viewModel.updateDepartureArrival(value: MRT.CipeteRaya.station)
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
