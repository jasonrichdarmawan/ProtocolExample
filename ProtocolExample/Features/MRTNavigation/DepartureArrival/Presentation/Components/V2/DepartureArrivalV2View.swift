//
//  DepartureArrivalV2View.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 25/07/23.
//

import SwiftUI

struct DepartureArrivalV2View: View {
    @ObservedObject private var viewModel: DepartureArrivalV2ViewModel
    
    init(viewModel: DepartureArrivalV2ViewModel = DepartureArrivalV2ViewModel()) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                DepartureV2View(value: $viewModel.departure, selected: $viewModel.departureSelected)
                Spacer()
                    .frame(width: 24, height: 24)
                    .padding(.leading, 16)
            }
            HStack(spacing: 0) {
                ArrivalV2View(value: $viewModel.arrival, selected: $viewModel.arrivalSelected)
                PlusCircleView()
                    .padding(.leading, 16)
            }
        }
    }
}

#if DEBUG
private struct DepartureArrivalV2ViewExample: View {
    @StateObject private var departureArrivalViewModel: DepartureArrivalV2ViewModel
    
    init(departureArrivalViewModel: DepartureArrivalV2ViewModel = DepartureArrivalV2ViewModel()) {
        self._departureArrivalViewModel = StateObject(wrappedValue: departureArrivalViewModel)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            DepartureArrivalV2View(viewModel: departureArrivalViewModel)
            
            VStack(alignment: .leading, spacing: 0) {
                Button("\(MRT.LebakBulusGrab.station.name) Station") {
                    departureArrivalViewModel.updateDepartureArrival(value: MRT.LebakBulusGrab.station)
                }
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .padding(.vertical, 16)
                
                Button("\(MRT.FatmawatiIndomaret.station.name) Station") {
                    departureArrivalViewModel.updateDepartureArrival(value: MRT.FatmawatiIndomaret.station)
                }
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .padding(.vertical, 16)
                
                Button("\(MRT.CipeteRaya.station.name) Station") {
                    departureArrivalViewModel.updateDepartureArrival(value: MRT.CipeteRaya.station)
                }
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .padding(.vertical, 16)
            }
            
            Spacer()
        }
        .padding(.horizontal, 32)
    }
}

struct DepartureArrivalV2View_Previews: PreviewProvider {
    static var previews: some View {
        DepartureArrivalV2ViewExample()
            .environment(\.locale, .init(identifier: "id-ID"))
    }
}
#endif
