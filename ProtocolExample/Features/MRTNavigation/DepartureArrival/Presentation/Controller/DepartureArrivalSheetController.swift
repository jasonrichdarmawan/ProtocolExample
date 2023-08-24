//
//  DepartureArrivalSheetController.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/08/23.
//

import SwiftUI

final class DepartureArrivalSheetController: Controller {
    private var id: UUID
    
    var coordinator: Coordinator?
    weak var viewController: UIViewController?
    
    private weak var sheetVM: (any DepartureArrivalSheetViewModel)?
    private weak var selectVM: (any DepartureArrivalViewModel)?
    private weak var scheduleVM: (any DepartureArrivalScheduleViewModel)?
    private weak var locationVM: (any DepartureArrivalLocationViewModel)?
    
    init(id: UUID = UUID(), coordinator: Coordinator? = nil) {
        self.id = id
        self.coordinator = coordinator
#if DEBUG
        print("\(type(of: self)) \(#function) \(id.uuidString)")
#endif
    }
    
    deinit {
#if DEBUG
        print("\(type(of: self)) \(#function) \(id.uuidString)")
#endif
    }
    
    func loadView() -> Bool {
        let sheetVM = DepartureArrivalSheetViewModelImpl(controller: self)
        self.sheetVM = sheetVM
        
        let selectVM = DepartureArrivalViewModelImpl()
        self.selectVM = selectVM
        
        let scheduleVM = DepartureArrivalScheduleViewModelImpl()
        self.scheduleVM = scheduleVM
        
        let locationVM = DepartureArrivalLocationViewModelImpl(controller: self)
        self.locationVM = locationVM
        
        let rootView = DepartureArrivalSheet(sheetVM: sheetVM, selectVM: selectVM, scheduleVM: scheduleVM, locationVM: locationVM)
        let viewController = HostingController(rootView: rootView)
        
        guard let sheetController = viewController.sheetPresentationController else { return false }
        
        sheetController.detents = [sheetVM.selectMRTStationNotPresentedDetent, .large()]
        sheetController.largestUndimmedDetentIdentifier = sheetVM.selectMRTStationNotPresentedDetentIdentifier
        
        sheetController.delegate = sheetVM
        
        guard let coordinator else { return false }
        
        coordinator.navigationController.present(viewController, animated: true)
        
        return true
    }
    
    func nextPage() -> Bool {
        guard let coordinator else { return false }
        guard coordinator.dismiss(animated: true) else { return false }
        return coordinator.showRoute(MRTNavigationRoute.CommutingPage)
    }
    
    func updateDeparture(newValue: Station) -> Bool {
        guard let viewModel = selectVM else { return false }
        
        viewModel.departure = newValue
        
        return true
    }
    
    func updateSelectedDetentIdentifier(_ selectedDetentIdentifier: UISheetPresentationController.Detent.Identifier?) {
        if let sheetController = viewController?.sheetPresentationController {
            sheetController.animateChanges {
                sheetController.selectedDetentIdentifier = selectedDetentIdentifier
            }
        }
    }
}
