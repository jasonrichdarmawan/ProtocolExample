//
//  CommutingSheetViewModelImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 18/08/23.
//

import Foundation
import UIKit

final class CommutingSheetViewModelImpl: NSObject, CommutingSheetViewModel {
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
        coordinator: Coordinator, hideDetail: Bool = true,
        hideDetailDetent: UISheetPresentationController.Detent = .custom(
            identifier: .init("hideDetailDetent"),
            resolver: { context in 390 }),
        hideDetailDetentIdentifier: UISheetPresentationController.Detent.Identifier = .init("hideDetailDetent")
    ) {
        self.coordinator = coordinator
        self.hideDetailDetent = hideDetailDetent
        self.hideDetailDetentIdentifier = hideDetailDetentIdentifier
        self.hideDetail = hideDetail
    }
}

extension CommutingSheetViewModelImpl: UISheetPresentationControllerDelegate {
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
