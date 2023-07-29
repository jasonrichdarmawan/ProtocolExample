//
//  ProtocolExampleApp.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/07/23.
//

import SwiftUI

@main
struct ProtocolExampleApp: App {
    @State private var isSoundOn = true
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                List {
                    NavigationLink("AlarmView", destination: {
                        NavigationLazyView {
                            AlarmView()
                        }
                        .navigationBarBackButtonHidden(true)
                    })
                    NavigationLink("DepartureArrivalPage", destination: {
                        NavigationLazyView {
                            DepartureArrivalPage()
                        }
                        .navigationBarBackButtonHidden(true)
                    })
                }
            }
        }
    }
}
