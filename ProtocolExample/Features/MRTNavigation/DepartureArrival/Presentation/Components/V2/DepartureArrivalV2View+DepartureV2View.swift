//
//  DepartureV2View.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 25/07/23.
//

import SwiftUI

extension DepartureArrivalV2View {
    struct DepartureV2View: View {
        @Binding var value: Station
        @Binding var selected: Bool
        
        var body: some View {
            Button {
                selected = true
            } label: {
                HStack(spacing: 0) {
                    CircleView()
                    Text("\(value.name) Station")
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
    
    struct CircleView: View {
        var body: some View {
            Image(systemName: "circle")
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundColor(Color("icon_circle"))
                .padding(.trailing, 8)
        }
    }
}

