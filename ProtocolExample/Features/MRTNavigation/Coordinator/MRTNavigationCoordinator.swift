//
//  MRTNavigationCoordinator.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

final class MRTNavigationCoordinator: NSObject, Coordinator {
    private let id: UUID
    
    private unowned var navigationController: UINavigationController
    
    private weak var departureArrivalPageVC: UIViewController?
    private weak var departureArrivalPageVM: (any DepartureArrivalPageViewModel)?
    
    private(set) weak var departureArrivalSheetVC: UIViewController?
    private weak var departureArrivalSheetVM: (any DepartureArrivalSheetViewModel)?
    private weak var departureArrivalSelectVM: (any DepartureArrivalViewModel)?
    private weak var departureArrivalScheduleVM: (any DepartureArrivalScheduleViewModel)?
    
    private weak var commutingPageVC: UIViewController?
    private weak var commutingPageVM: (any CommutingPageViewModel)?
    
    private weak var commutingSheetVC: UIViewController?
    private weak var commutingSheetVM: (any CommutingSheetViewModel)?
    
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
    
    func popRoute(animated: Bool) -> Bool {
        navigationController.popViewController(animated: animated)
        return true
    }
    
    private func showMRTNavigationRoute(_ route: MRTNavigationRoute) -> Bool {
        switch route {
        case .DepartureArrivalPage:
            guard departureArrivalPageVC == nil else { return false }
            
            let pageVM = DepartureArrivalPageViewModelImpl(coordinator: self)
            self.departureArrivalPageVM = pageVM
            
            let view = DepartureArrivalPage(pageVM: pageVM)
            let viewController = HostingController(rootView: view)
            
            navigationController.pushViewController(viewController, animated: true)
            
            return true
        case .DepartureArrivalSheet:
            guard departureArrivalSheetVC == nil else { return false }
            
            let sheetVM = DepartureArrivalSheetViewModelImpl(coordinator: self)
            self.departureArrivalSheetVM = sheetVM
            
            let selectVM = DepartureArrivalViewModelImpl()
            self.departureArrivalSelectVM = selectVM
            
            let scheduleVM = DepartureArrivalScheduleViewModelImpl()
            self.departureArrivalScheduleVM = scheduleVM
            
            let view = DepartureArrivalSheet(sheetVM: sheetVM, selectVM: selectVM, scheduleVM: scheduleVM)
            let viewController = HostingController(rootView: view)
            departureArrivalSheetVC = viewController
            
            guard let sheetController = viewController.sheetPresentationController else { return false }

            sheetController.detents = [sheetVM.selectMRTStationNotPresentedDetent, .large()]
            sheetController.largestUndimmedDetentIdentifier = sheetVM.selectMRTStationNotPresentedDetentIdentifier
            
            sheetController.delegate = sheetVM
            
            navigationController.present(viewController, animated: true)
            
            guard let navigationController = navigationController as? NavigationController else { return false }
            
            navigationController.willPopHandler = { navigationController.dismiss(animated: true) }
            
            return true
        case .CommutingPage:
            guard commutingPageVC == nil else { return false }
            
            let viewModel = CommutingPageViewModelImpl(coordinator: self)
            commutingPageVM = viewModel
            
            let view = CommutingPage(pageVM: viewModel)
            let viewController = HostingController(rootView: view)
            
            // if the sheet is dismissed then dismiss the page as well.
            if departureArrivalSheetVC != nil { navigationController.dismiss(animated: true) }
            
            navigationController.pushViewController(viewController, animated: true)
            
            return true
        case .CommutingSheet:
            guard commutingSheetVC == nil else { return false }
            
            let viewModel = CommutingSheetViewModelImpl()
            commutingSheetVM = viewModel
            
            let view = CommutingSheet(sheetVM: viewModel)
            let viewController = HostingController(rootView: view)
            
            // disable interactive swipe to dismiss the view controller
            viewController.isModalInPresentation = true
            
            commutingSheetVC = viewController
            
            guard let sheetController = viewController.sheetPresentationController else { return false }
            
            sheetController.detents = [.medium(), .large()]
            sheetController.largestUndimmedDetentIdentifier = .medium
            
            sheetController.delegate = viewModel
            
            navigationController.present(viewController, animated: true)
            
            guard let navigationController = navigationController as? NavigationController else { return false }
            
            return true
        }
    }
}
