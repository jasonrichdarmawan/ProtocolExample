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
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            GridRow {
                Circle()
                    .stroke(.blue, lineWidth: 4)
                    .frame(width: 16, height: 16)
                    .padding(.trailing, 16)
                
                DepartureOrArrivalButtonView(value: $viewModel.departure, selected: $viewModel.departureSelected)
            }
            
            GridRow {
                Line()
                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [8,8]))
                    .foregroundColor(Color("departureArrival_line"))
                    .frame(width: 1, height: 24)
                    .padding(.trailing, 16)
                
                
            }
            
            GridRow {
                Circle()
                    .stroke(.blue, lineWidth: 4)
                    .frame(width: 16, height: 16)
                    .padding(.trailing, 16)
                
                DepartureOrArrivalButtonView(value: $viewModel.arrival, selected: $viewModel.arrivalSelected)
            }
        }
//        VStack(spacing: 0) {
//            HStack(spacing: 0) {
//                Circle()
//                    .stroke(.blue, lineWidth: 4)
//                    .frame(width: 16, height: 16)
//                    .padding(.trailing, 16)
//                DepartureOrArrivalButtonView(value: $viewModel.departure, selected: $viewModel.departureSelected)
//            }
//            Line()
//                .stroke(style: StrokeStyle(lineWidth: 2, dash: [8,8]))
//                .frame(height: 24)
//            HStack(spacing: 0) {
//                Circle()
//                    .stroke(.blue, lineWidth: 4)
//                    .frame(width: 16, height: 16)
//                    .padding(.trailing, 16)
//                DepartureOrArrivalButtonView(value: $viewModel.arrival, selected: $viewModel.arrivalSelected)
//            }
//        }
    }
}

#if DEBUG
private struct DepartureArrivalViewExample: View {
    @StateObject private var departureArrivalViewModel: DepartureArrivalViewModel
    
    init(departureArrivalViewModel: DepartureArrivalViewModel = DepartureArrivalViewModel()) {
        self._departureArrivalViewModel = StateObject(wrappedValue: departureArrivalViewModel)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            DepartureArrivalView(viewModel: departureArrivalViewModel)
            
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
    }
}

struct DepartureArrivalViewExample_Previews: PreviewProvider {
    static var previews: some View {
        DepartureArrivalViewExample()
            .environment(\.locale, .init(identifier: "id-ID"))
    }
}
#endif
