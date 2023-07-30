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
        @Binding var selectedDetent: PresentationDetent
        
        init(
            value: Binding<Station?> = .constant(nil),
            selected: Binding<Bool> = .constant(true),
            selectedDetent: Binding<PresentationDetent> = .constant(.header)
        ) {
            self._value = value
            self._selected = selected
            self._selectedDetent = selectedDetent
        }
        
        var body: some View {
            Button {
                withAnimation {
                    selected = true
                    selectedDetent = .large
                }
            } label: {
                Text((value != nil) ? "\(value?.name ?? "") Station" : "Where to?")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
            }
            .buttonStyle(selected ? Either.left(.bordered) : .right(.borderedProminent))
        }
    }
}
