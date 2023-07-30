//
//  ProtocolExampleApp.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/07/23.
//

import SwiftUI

@main
struct ProtocolExampleApp: App {
    @State private var isAlarmViewPresented = false
    @State private var isDepartureArrivalPagePresented = false
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                VStack {
                    List {
                        Button {
                            isAlarmViewPresented = true
                        } label: {
                            Text("AlarmView")
                        }
                        Button {
                            isDepartureArrivalPagePresented = true
                        } label: {
                            Text("DepartureArrivalPage")
                        }
                    }
                }
                .navigationDestination(isPresented: $isAlarmViewPresented) {
                    NavigationLazyView {
                        AlarmView()
                    }
                }
                .navigationDestination(isPresented: $isDepartureArrivalPagePresented) {
                    NavigationLazyView {
                        DepartureArrivalPage()
                    }
                    .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}
