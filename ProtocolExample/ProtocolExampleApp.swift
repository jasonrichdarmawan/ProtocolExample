//
//  ProtocolExampleApp.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/07/23.
//

import SwiftUI

@main
struct ProtocolExampleApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                NavigationLink("DepartureArrivalPage", destination: {
                    NavigationLazyView {
                        DepartureArrivalPage()
                    }
                })
            }
        }
    }
}
