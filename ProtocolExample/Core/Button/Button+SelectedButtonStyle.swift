//
//  Button+SelectedButtonStyle.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/07/23.
//

import SwiftUI

extension Button {
    @ViewBuilder
    func selectedButtonStyle(_ selected: Bool) -> some View {
        switch selected {
        case true:
            self.buttonStyle(.bordered)
        case false:
            self.buttonStyle(.borderedProminent)
        }
    }
}
