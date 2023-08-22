//
//  DetailSheetViewModelImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 22/08/23.
//

import UIKit

final class CommutingDetailViewModelImpl: NSObject, CommutingDetailViewModel {
    var coordinator: Coordinator
    
    var hideDetailDetent: UISheetPresentationController.Detent
    var hideDetailDetentIdentifier: UISheetPresentationController.Detent.Identifier
    
    @Published var hideDetail: Bool {
        didSet {
            if let coordinator = coordinator as? MRTNavigationCoordinator {
                guard let sheetController = coordinator.commutingSheetVC?.sheetPresentationController else { return }
                
                sheetController.animateChanges {
                    if hideDetail {
                        sheetController.selectedDetentIdentifier = hideDetailDetentIdentifier
                    } else {
                        sheetController.selectedDetentIdentifier = .large
                    }
                }
            }
        }
    }
    
    init(
        coordinator: Coordinator,
        hideDetailDetent: UISheetPresentationController.Detent = .custom(
            identifier: .init("hideDetailDetent"),
            resolver: { context in 390 }),
        hideDetailDetentIdentifier: UISheetPresentationController.Detent.Identifier = .init("hideDetailDetent"),
        hideDetail: Bool = true
    ) {
        self.coordinator = coordinator
        self.hideDetailDetent = hideDetailDetent
        self.hideDetailDetentIdentifier = hideDetailDetentIdentifier
        self.hideDetail = hideDetail
    }
    
    func setAsDelegate() -> Bool {
        guard let coordinator = coordinator as? MRTNavigationCoordinator else { return false }
        
        guard let sheetController = coordinator.commutingSheetVC?.sheetPresentationController else { return false }
        
        sheetController.delegate = self
        
        return true
    }
}

extension CommutingDetailViewModelImpl: UISheetPresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        _ = coordinator.popViewController(animated: true)
    }
    
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        if sheetPresentationController.selectedDetentIdentifier == .large {
            hideDetail = false
        }

        if sheetPresentationController.selectedDetentIdentifier == hideDetailDetentIdentifier {
            hideDetail = true
        }
    }
}
