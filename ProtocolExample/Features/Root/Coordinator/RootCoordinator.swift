//
//  RootCoordinator.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

final class RootCoordinator: Coordinator {
    private let id: UUID
    
    internal unowned let navigationController: UINavigationController
    
    private weak var rootVC: UIViewController?
    
    private weak var alarmVC: UIViewController?
    private weak var alarmVM: (any AlarmViewModel)?

    private weak var mrtNavigationC: Coordinator?
    
    private weak var notifyOnceUseCase: NotifyWhenNearMRTStationOnce?
    private weak var locationVC: UIViewController?
    
    init(
        id: UUID = UUID(),
        navigationController: UINavigationController
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
            return showRootRoute(route)
        }
        return false
    }
}

extension RootCoordinator {
    private func showRootRoute(_ route: RootRoute) -> Bool {
        switch route {
        case .Root: return pushRoot()
        case .Alarm: return pushAlarm()
        case .DepartureArrivalPage: return pushDepartureArrivalPage()
        case .Location: return pushLocation()
        }
    }
}

// MARK: Root
extension RootCoordinator {
    private func pushRoot() -> Bool {
        guard rootVC == nil else { return false }
        
        let view = RootView(coordinator: self)
        let viewController = HostingController(rootView: view)
        rootVC = viewController
        
        navigationController.pushViewController(viewController, animated: true)
        
        return true
    }
}

// MARK: Alarm
extension RootCoordinator {
    private func pushAlarm() -> Bool {
        guard alarmVC == nil else { return false }
        
        let viewModel = AlarmViewModelImpl()
        alarmVM = viewModel
        
        let view = AlarmView(alarVM: viewModel)
        let viewController = UIHostingController(rootView: view)
        alarmVC = viewController
        
        navigationController.pushViewController(viewController, animated: true)
        navigationController.setNavigationBarHidden(false, animated: true)
        
        return true
    }
}

// MARK: DepartureArrival
extension RootCoordinator {
    private func pushDepartureArrivalPage() -> Bool {
        guard mrtNavigationC == nil else { return false }
        let coordinator = MRTNavigationCoordinator(navigationController: navigationController)
        mrtNavigationC = coordinator
        return coordinator.showRoute(MRTNavigationRoute.DepartureArrivalPage)
    }
}

extension RootCoordinator {
    private func pushLocation() -> Bool {
        guard locationVC == nil else { return false }
        
        let notifyOnceUseCase = NotifyWhenNearMRTStationOnceImpl()
        self.notifyOnceUseCase = notifyOnceUseCase
        
        let locationVM = LocationExampleViewModelImpl(notifyOnceUseCase: notifyOnceUseCase)
        
        let view = LocationExamplePage(locationVM: locationVM)
        let viewController = HostingController(rootView: view)
        locationVC = viewController
        
        navigationController.pushViewController(viewController, animated: true)
        navigationController.setNavigationBarHidden(false, animated: true)
        
        return true
    }
}
