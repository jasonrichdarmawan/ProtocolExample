//
//  PlusCircleView.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 25/07/23.
//

import SwiftUI

extension DepartureArrivalV2View {
    struct PlusCircleView: View {
        var body: some View {
            Button {
                
            } label: {
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .tint(Color("addButton"))
            }
        }
    }
}
