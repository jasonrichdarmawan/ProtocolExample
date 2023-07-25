//
//  DepartureArrivalView+DepartureArrivalButtonView.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 25/07/23.
//

import SwiftUI

extension DepartureArrivalView {
    struct DepartureOrArrivalButtonView: View {
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
}