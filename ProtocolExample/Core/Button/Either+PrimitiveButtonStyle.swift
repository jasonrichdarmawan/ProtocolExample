//
//  Either+PrimitiveButtonStyle.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 27/07/23.
//

import SwiftUI

extension Either: PrimitiveButtonStyle where Left: PrimitiveButtonStyle, Right: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        switch self {
        case .left(let left):
            left.makeBody(configuration: configuration)
        case .right(let right):
            right.makeBody(configuration: configuration)
        }
    }
}
