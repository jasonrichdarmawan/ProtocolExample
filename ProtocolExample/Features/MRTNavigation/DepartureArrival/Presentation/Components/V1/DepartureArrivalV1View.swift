//
//  DepartureArrivalView.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/07/23.
//

import SwiftUI

struct DepartureArrivalV1View<ViewModel>: View where ViewModel: DepartureArrivalViewModel {
    @ObservedObject var viewModel: ViewModel
    @Binding var selectedDetent: PresentationDetent
    
    init(viewModel: ViewModel = DepartureArrivalV1ViewModel(), selectedDetent: Binding<PresentationDetent> = .constant(.header)) {
        self.viewModel = viewModel
        self._selectedDetent = selectedDetent
    }
    
    var body: some View {
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            GridRow {
                Circle()
                    .stroke(.blue, lineWidth: 4)
                    .frame(width: 16, height: 16)
                    .padding(.trailing, 16)
                
                DepartureOrArrivalButtonView(value: $viewModel.departure, selected: $viewModel.departureSelected, selectedDetent: $selectedDetent)
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
                
                DepartureOrArrivalButtonView(value: $viewModel.arrival, selected: $viewModel.arrivalSelected, selectedDetent: $selectedDetent)
            }
        }
    }
}

#if DEBUG
private struct DepartureArrivalViewExample<DepartureArrivalVM>: View where DepartureArrivalVM: DepartureArrivalViewModel {
    @StateObject private var departureArrivalViewModel: DepartureArrivalVM
    
    init(departureArrivalViewModel: DepartureArrivalVM = DepartureArrivalV1ViewModel()) {
        self._departureArrivalViewModel = StateObject(wrappedValue: departureArrivalViewModel)
    }
    
    var body: some View {
        VStack(spacing: 32) {
            DepartureArrivalV1View(viewModel: departureArrivalViewModel)
            
            VStack(spacing: 20) {
                Button {
                    withAnimation {
                        _ = departureArrivalViewModel.updateDepartureArrival(value: MRT.LebakBulusGrab.station)
                    }
                } label: {
                    Text("\(MRT.LebakBulusGrab.station.name) Station")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .font(.headline)
                .buttonStyle(.borderedProminent)
                
                Button {
                    withAnimation {
                        _ = departureArrivalViewModel.updateDepartureArrival(value: MRT.FatmawatiIndomaret.station)
                    }
                } label: {
                    Text("\(MRT.FatmawatiIndomaret.station.name) Station")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .font(.headline)
                .buttonStyle(.borderedProminent)
                
                Button {
                    withAnimation {
                        _ = departureArrivalViewModel.updateDepartureArrival(value: MRT.CipeteRaya.station)
                    }
                } label: {
                    Text("\(MRT.CipeteRaya.station.name) Station")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .font(.headline)
                .buttonStyle(.borderedProminent)
            }
            
            Spacer()
        }
        .padding(.top, 32)
        .padding(.horizontal, 32)
    }
}

struct DepartureArrivalViewExample_Previews: PreviewProvider {
    static var previews: some View {
        DepartureArrivalViewExample()
            .environment(\.locale, .init(identifier: "id-ID"))
    }
}
#endif
