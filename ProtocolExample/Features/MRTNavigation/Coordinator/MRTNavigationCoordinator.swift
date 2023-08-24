//
//  MRTNavigationCoordinator.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

final class MRTNavigationCoordinator: NSObject, Coordinator {
    private let id: UUID
    
    internal unowned var navigationController: UINavigationController
    
    private weak var departureArrivalPageVC: UIViewController?
    private weak var departureArrivalPageVM: (any DepartureArrivalPageViewModel)?
    
    private(set) weak var departureArrivalSheetVC: UIViewController?
    private weak var departureArrivalSheetVM: (any DepartureArrivalSheetViewModel)?
    private(set) weak var departureArrivalSelectVM: (any DepartureArrivalViewModel)?
    private weak var departureArrivalScheduleVM: (any DepartureArrivalScheduleViewModel)?
    private weak var departureLocationVM: (any DepartureArrivalLocationViewModel)?
    
    private weak var commutingPageVC: UIViewController?
    private weak var commutingPageVM: (any CommutingPageViewModel)?
    
    private(set) weak var commutingSheetVC: UIViewController?
    private weak var commutingSheetVM: (any CommutingSheetViewModel)?
    private weak var commutingDetailVM: (any CommutingDetailViewModel)?
    
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
        guard departureArrivalPageVC == nil else { return false }
        
        let pageVM = DepartureArrivalPageViewModelImpl(coordinator: self)
        self.departureArrivalPageVM = pageVM
        
        let view = DepartureArrivalPage(pageVM: pageVM)
        let viewController = HostingController(rootView: view)
        
        navigationController.pushViewController(viewController, animated: true)
        
        return true
    }
    
    private func presentDepartureArrivalSheet() -> Bool {
        guard departureArrivalSheetVC == nil else { return false }
        
        let sheetVM = DepartureArrivalSheetViewModelImpl(coordinator: self)
        self.departureArrivalSheetVM = sheetVM
        
        let selectVM = DepartureArrivalViewModelImpl()
        self.departureArrivalSelectVM = selectVM
        
        let scheduleVM = DepartureArrivalScheduleViewModelImpl()
        self.departureArrivalScheduleVM = scheduleVM
        
        let locationVM = DepartureArrivalLocationViewModelImpl(coordinator: self)
        self.departureLocationVM = locationVM
        
        let view = DepartureArrivalSheet(sheetVM: sheetVM, selectVM: selectVM, scheduleVM: scheduleVM, locationVM: locationVM)
        let viewController = HostingController(rootView: view)
        
        // prevents the interactive dismissal of the view controller while it is onscreen.
//        viewController.isModalInPresentation = true
        
        departureArrivalSheetVC = viewController
        
        guard let sheetController = viewController.sheetPresentationController else { return false }

        sheetController.detents = [sheetVM.selectMRTStationNotPresentedDetent, .large()]
        sheetController.largestUndimmedDetentIdentifier = sheetVM.selectMRTStationNotPresentedDetentIdentifier
        
        sheetController.delegate = sheetVM
        
        navigationController.present(viewController, animated: true)
        
        return true
    }
    
    func updateDeparture(newValue: Station) -> Bool {
        guard let viewModel = departureArrivalSelectVM else { return false }
        
        viewModel.departure = newValue
        
        return true
    }
}

// MARK: Commuting
extension MRTNavigationCoordinator {
    private func pushCommutingPage() -> Bool {
        guard commutingPageVC == nil else { return false }
        
        let viewModel = CommutingPageViewModelImpl(coordinator: self)
        commutingPageVM = viewModel
        
        let view = CommutingPage(pageVM: viewModel)
        let viewController = HostingController(rootView: view)
        
        navigationController.pushViewController(viewController, animated: true)
        
        return true
    }
    
    private func presentCommutingSheet() -> Bool {
        guard commutingSheetVC == nil else { return false }
        
        let sheetVM = CommutingSheetViewModelImpl(coordinator: self)
        commutingSheetVM = sheetVM
        
        let detailVM = CommutingDetailViewModelImpl(coordinator: self)
        commutingDetailVM = detailVM
        
        let view = CommutingSheet(sheetVM: sheetVM, detailVM: detailVM)
        let viewController = HostingController(rootView: view)
        commutingSheetVC = viewController
        
        guard let sheetController = viewController.sheetPresentationController else { return false }
        
        sheetController.detents = [detailVM.hideDetailDetent, .large()]
        sheetController.largestUndimmedDetentIdentifier = detailVM.hideDetailDetentIdentifier
        
        navigationController.present(viewController, animated: true)
        
        return true
    }
}
