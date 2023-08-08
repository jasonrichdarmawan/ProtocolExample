//
//  DepartureArrivalV2Page.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 25/07/23.
//

import SwiftUI

struct DepartureArrivalPage: ViewControllable {
    private var coordinator: Coordinator

    init(
        coordinator: Coordinator
    ) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Where to go today?")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color("departureArrival_text_active"))
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(32)
        .background(.blue)
    }
    
    func viewWillAppear(_ viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(true, animated: false)
        
        _ = coordinator.showRoute(MRTNavigationRoute.DepartureArrivalSheet)
    }
}

#if DEBUG
struct DepartureArrivalPage_Preview: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DepartureArrivalPage(coordinator: MRTNavigationCoordinator(navigationController: NavigationController()))
                .environment(\.locale, .init(identifier: "id-ID"))
        }
    }
}
#endif
