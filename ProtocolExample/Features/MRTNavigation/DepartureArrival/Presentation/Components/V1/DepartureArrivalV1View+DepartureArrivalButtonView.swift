//
//  DepartureArrivalView+DepartureArrivalButtonView.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 25/07/23.
//

import SwiftUI

extension DepartureArrivalV1View {
    struct DepartureOrArrivalButtonView: View {
        @Binding var value: Station?
        @Binding var selected: Bool
        @Binding var isSelectMRTStationPresented: Bool
        
        init(
            value: Binding<Station?> = .constant(nil),
            selected: Binding<Bool> = .constant(true),
            isSelectMRTStationPresented: Binding<Bool> = .constant(false)
        ) {
            self._value = value
            self._selected = selected
            self._isSelectMRTStationPresented = isSelectMRTStationPresented
        }
        
        var body: some View {
            Button {
                withAnimation {
                    selected = true
                    isSelectMRTStationPresented = true
                }
            } label: {
                Text((value != nil) ? "\(value?.name ?? "") Station" : "Where to?")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
            }
            .buttonStyle(selected ? Either.left(.bordered) : .right(.borderedProminent))
            .overlay(RoundedRectangle(cornerRadius: 4)
                .stroke(selected && isSelectMRTStationPresented ? Color.label : Color.systemBackground,
                        lineWidth: 2)
            )
        }
    }
}
