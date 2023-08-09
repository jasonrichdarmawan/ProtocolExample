//
//  RootCoordinator.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

final class RootCoordinator: Coordinator {
    private let id: UUID
    
    private unowned let navigationController: UINavigationController
    
    private weak var rootVC: UIViewController?
    
    private weak var alarmVC: UIViewController?
    private weak var alarmVM: (any AlarmViewModel)?

    private weak var mrtNavigationC: Coordinator?
    
    init(
        id: UUID = UUID(),
        navigationController: UINavigationController = NavigationController()
    ) {
        self.id = id
        self.navigationController = navigationController
#if DEBUG
        print("\(type(of: self)) \(#function) \(id.uuidString)")
#endif
    }
    
    deinit {
#if DEBUG
        print("\(type(of: self)) \(#function) \(id.uuidString)")
#endif
    }
    
    func showRoute(_ route: NavigationRoute) -> Bool {
        if let route = route as? RootRoute {
            return pushRootRoute(route)
        }
        return false
    }
    
    private func pushRootRoute(_ route: RootRoute) -> Bool {
        switch route {
        case .Root:
            guard rootVC == nil else { return false }
            
            let view = RootView(coordinator: self)
            let viewController = HostingController(rootView: view)
            rootVC = viewController
            
            navigationController.pushViewController(viewController, animated: true)
            
            return true
        case .Alarm:
            guard alarmVC == nil else { return false }
            
            let viewModel = AlarmViewModelImpl()
            alarmVM = viewModel
            
            let view = AlarmView(alarVM: viewModel)
            let viewController = HostingController(rootView: view)
            alarmVC = viewController
            
            navigationController.pushViewController(viewController, animated: true)
            
            return true
        case .DepartureArrivalPage:
            guard mrtNavigationC == nil else { return false }
            let coordinator = MRTNavigationCoordinator(navigationController: navigationController)
            mrtNavigationC = coordinator
            return coordinator.showRoute(MRTNavigationRoute.DepartureArrivalPage)
        }
    }
}
