//
//  DepartureArrivalPageViewModel.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 28/07/23.
//

import SwiftUI

class DepartureArrivalSheetViewModelImpl: NSObject, DepartureArrivalSheetViewModel {
    private var controller: Controller
    
    var selectMRTStationNotPresentedDetent: UISheetPresentationController.Detent
    var selectMRTStationNotPresentedDetentIdentifier: UISheetPresentationController.Detent.Identifier
    
    @Published var isPresented: Bool {
        didSet {
            if isPresented {
                updateSelectedDetentIdentifier(.large)
            } else {
                updateSelectedDetentIdentifier(selectMRTStationNotPresentedDetentIdentifier)
            }
        }
    }
    
    init(
        controller: Controller,
        selectMRTStationNotPresentedDetent: UISheetPresentationController.Detent = .custom(identifier: .init("selectMRTStationNotPresentedDetent"), resolver: { context in 648 }),
        selectMRTStationNotPresentedDetentIdentifier: UISheetPresentationController.Detent.Identifier = .init("selectMRTStationNotPresentedDetent"),
        isPresented: Bool = false
    ) {
        self.controller = controller
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
        guard let coordinator = controller.coordinator else { return false }
        guard coordinator.dismiss(animated: true) else { return false }
        
        return coordinator.showRoute(MRTNavigationRoute.CommutingPage)
    }
    
    private func updateSelectedDetentIdentifier(_ selectedDetentIdentifier: UISheetPresentationController.Detent.Identifier?) {
        if let sheetController = controller.viewController?.sheetPresentationController {
            sheetController.animateChanges {
                sheetController.selectedDetentIdentifier = selectedDetentIdentifier
            }
        }
    }
}

extension DepartureArrivalSheetViewModelImpl: UISheetPresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        _ = controller.coordinator?.navigationController.popViewController(animated: true)
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
