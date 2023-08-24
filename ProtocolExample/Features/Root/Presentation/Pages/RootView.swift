//
//  RootView.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 03/08/23.
//

import SwiftUI

struct RootView: ViewControllable {
    private var coordinator: Coordinator
    
    init(
        coordinator: Coordinator
    ) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        List {
            Button {
                _ = coordinator.showRoute(RootRoute.Alarm)
            } label: {
                Text("Alarm Component")
            }
            
            Button {
                _ = coordinator.showRoute(RootRoute.DepartureArrivalPage)
            } label: {
                Text("Select Departure and Arrival Page")
            }
            
            Button {
                _ = coordinator.showRoute(RootRoute.Location)
            } label: {
                Text("Location")
            }
        }
    }
}

extension RootView {
    func viewWillAppear(_ viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
