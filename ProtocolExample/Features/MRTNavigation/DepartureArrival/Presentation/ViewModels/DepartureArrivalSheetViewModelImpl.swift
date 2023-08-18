//
//  DepartureArrivalPageViewModel.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 28/07/23.
//

import SwiftUI

class DepartureArrivalSheetViewModelImpl: NSObject, DepartureArrivalSheetViewModel {
    private var coordinator: Coordinator
    
    var selectMRTStationNotPresentedDetent: UISheetPresentationController.Detent
    var selectMRTStationNotPresentedDetentIdentifier: UISheetPresentationController.Detent.Identifier
    
    @Published var isPresented: Bool {
        didSet {
            if isPresented {
                updateDepartureArrivalSheetSelectedDetentIdentifier(.large)
            } else {
                updateDepartureArrivalSheetSelectedDetentIdentifier(selectMRTStationNotPresentedDetentIdentifier)
            }
        }
    }
    
    init(
        coordinator: Coordinator,
        selectMRTStationNotPresentedDetent: UISheetPresentationController.Detent = .custom(identifier: .init("topPadding105"), resolver: { context in context.maximumDetentValue - 105 }),
        selectMRTStationNotPresentedDetentIdentifier: UISheetPresentationController.Detent.Identifier = .init("topPadding105"),
        isPresented: Bool = false
    ) {
        self.coordinator = coordinator
        self.selectMRTStationNotPresentedDetent = selectMRTStationNotPresentedDetent
        self.selectMRTStationNotPresentedDetentIdentifier = selectMRTStationNotPresentedDetentIdentifier
        self.isPresented = isPresented
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    deinit {
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    func nextPage() -> Bool {
        return coordinator.showRoute(MRTNavigationRoute.CommutingPage)
    }
    
    private func updateDepartureArrivalSheetSelectedDetentIdentifier(_ selectedDetentIdentifier: UISheetPresentationController.Detent.Identifier?) {
        if let coordinator = coordinator as? MRTNavigationCoordinator,
           let sheetController = coordinator.departureArrivalSheetVC?.sheetPresentationController {
            sheetController.animateChanges {
                sheetController.selectedDetentIdentifier = selectedDetentIdentifier
            }
        }
    }
}

extension DepartureArrivalSheetViewModelImpl: UISheetPresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        _ = coordinator.popRoute(animated: true)
    }
    
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        if sheetPresentationController.selectedDetentIdentifier == .large {
            isPresented = true
        }
        
        if sheetPresentationController.selectedDetentIdentifier == selectMRTStationNotPresentedDetentIdentifier {
            isPresented = false
        }
    }
}
