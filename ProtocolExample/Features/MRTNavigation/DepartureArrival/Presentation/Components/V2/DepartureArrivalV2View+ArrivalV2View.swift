//
//  ArrivalV2View.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 25/07/23.
//

import SwiftUI

extension DepartureArrivalV2View {
    struct ArrivalV2View: View {
        @Binding var value: Station?
        @Binding var selected: Bool
        
        var body: some View {
            Button {
                selected = true
            } label: {
                HStack(spacing: 0) {
                    LocationFillView()
                    Text((value != nil) ? "\(value?.name ?? "") Station" : "Where to?")
                        .foregroundColor(selected ? Color("departureArrival_text_selectedv2") : Color("departureArrival_text_activev2"))
                        .font(.body)
                        .fontWeight(selected ? .bold : .regular)
                    Spacer()
                }
                .padding(8)
                .background(selected ? Color("departureArrival_background_selectedv2") : nil)
                .cornerRadius(4)
            }

        }
    }

    struct LocationFillView: View {
        var body: some View {
            Image(systemName: "location.fill")
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundColor(Color("icon_location fill"))
                .padding(.trailing, 8)
        }
    }
}
