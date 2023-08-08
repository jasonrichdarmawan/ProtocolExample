//
//  RootView.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 03/08/23.
//

import SwiftUI


//protocol RootViewModel: ObservableObject {
//    func navigateToAlarmComponent(_ viewController: UIViewController?) -> Bool
//    func navigateToDepartureArrivalPage(_ viewController: UIViewController?) -> Bool
//}

//class RootViewModeImpll: RootViewModel {
//    func navigateToAlarmComponent(_ viewController: UIViewController?) -> Bool {
//        guard let navigationController = viewController?.navigationController else { return false }
//
//        let view = AlarmView()
//
//        navigationController.pushViewController(view.viewController, animated: true)
//
//        return true
//    }
//
//    func navigateToDepartureArrivalPage(_ viewController: UIViewController?) -> Bool {
//        guard let navigationController = viewController?.navigationController else { return false }
//
//        let view = DepartureArrivalPage()
//
//        navigationController.pushViewController(view.viewController, animated: true)
//
//        return true
//    }
//}

struct RootView: ViewControllable {
    private var coordinator: Coordinator
    
    init(
        coordinator: Coordinator = RootCoordinator()
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
        }
    }
}

extension RootView {
    func viewWillAppear(_ viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
