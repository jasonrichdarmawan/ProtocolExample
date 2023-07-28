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
        
        var body: some View {
            Button {
                withAnimation {
                    selected = true
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
