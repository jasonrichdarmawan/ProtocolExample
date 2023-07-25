//
//  NavigationLazyView.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 25/07/23.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @escaping () -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}
