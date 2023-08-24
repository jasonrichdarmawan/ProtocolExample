//
//  MRTNavigationCoordinator.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

final class MRTNavigationCoordinator: NSObject, Coordinator {
    private let id: UUID
    
    unowned var navigationController: UINavigationController
    
    private weak var departureArrivalPageC: Controller?
    
    private weak var departureArrivalSheetC: Controller?
    
    private weak var commutingPageC: Controller?
    
    private weak var commutingSheetC: Controller?
    
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
        if let route = route as? MRTNavigationRoute {
            return showMRTNavigationRoute(route)
        }
        return false
    }
}

extension MRTNavigationCoordinator {
    private func showMRTNavigationRoute(_ route: MRTNavigationRoute) -> Bool {
        switch route {
        case .DepartureArrivalPage: return pushDepartureArrivalPage()
        case .DepartureArrivalSheet: return presentDepartureArrivalSheet()
        case .CommutingPage: return pushCommutingPage()
        case .CommutingSheet: return presentCommutingSheet()
        }
    }
}

// MARK: DepartureArrival
extension MRTNavigationCoordinator {
    private func pushDepartureArrivalPage() -> Bool {
        guard departureArrivalPageC == nil else { return false }
        
        let controller = DepartureArrivalPageController(coordinator: self)
        departureArrivalPageC = controller
        
        return controller.loadView()
    }
    
    private func presentDepartureArrivalSheet() -> Bool {
        guard departureArrivalSheetC == nil else { return false }
        
        let controller = DepartureArrivalSheetController(coordinator: self)
        departureArrivalSheetC = controller
        
        return controller.loadView()
    }
}

// MARK: Commuting
extension MRTNavigationCoordinator {
    private func pushCommutingPage() -> Bool {
        guard commutingPageC == nil else { return false }
        
        let controller = CommutingPageController(coordinator: self)
        commutingPageC = controller
        
        return controller.loadView()
    }
    
    private func presentCommutingSheet() -> Bool {
        guard commutingSheetC == nil else { return false }
        
        let controller = CommutingSheetController(coordinator: self)
        commutingSheetC = controller
        
        return controller.loadView()
    }
}
