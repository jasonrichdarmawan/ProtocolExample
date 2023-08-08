//
//  MRTNavigationCoordinator.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

final class MRTNavigationCoordinator: NSObject, Coordinator {
    typealias SheetVM = DepartureArrivalSheetViewModelImpl
    typealias SelectVM = DepartureArrivalViewModelImpl
    typealias ScheduleVM = DepartureArrivalScheduleViewModelImpl
    typealias CommutingVM = CommutingPageViewModelImpl
    
    private let id: UUID
    
    private unowned var navigationController: UINavigationController
    
    private weak var departureArrivalPageVC: UIViewController?
    private weak var sheetVM: SheetVM?
    private weak var selectVM: SelectVM?
    private weak var scheduleVM: ScheduleVM?
    
    private weak var departureArrivalSheetVC: UIViewController?
    
    private weak var commutingPageVC: UIViewController?
    private weak var commutingVM: CommutingVM?
    
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
            
            let view = DepartureArrivalPage(coordinator: self)
            let viewController = HostingController(rootView: view)
            
            navigationController.pushViewController(viewController, animated: true)
            
            return true
        case .DepartureArrivalSheet:
            guard departureArrivalSheetVC == nil else { return false }
            
            let sheetVM = SheetVM(coordinator: self)
            self.sheetVM = sheetVM
            
            let selectVM = SelectVM()
            self.selectVM = selectVM
            
            let scheduleVM = ScheduleVM()
            self.scheduleVM = scheduleVM
            
            let view = DepartureArrivalSheet(coordinator: self, sheetVM: sheetVM, selectVM: selectVM, scheduleVM: scheduleVM)
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
            
            let viewModel = CommutingPageViewModelImpl()
            commutingVM = viewModel
            let view = CommutingPage(commutingVM: viewModel)
            let viewController = HostingController(rootView: view)
            
            if departureArrivalSheetVC != nil { navigationController.dismiss(animated: true) }
            
            navigationController.pushViewController(viewController, animated: true)
            
            return true
        }
    }
}
