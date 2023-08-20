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
    
    @Published var hideDetail: Bool {
        didSet {
            if let coordinator = coordinator as? MRTNavigationCoordinator {
                guard let sheetController = coordinator.commutingSheetVC?.sheetPresentationController else { return }
                
                sheetController.animateChanges {
                    if hideDetail {
                        sheetController.selectedDetentIdentifier = .medium
                    } else {
                        sheetController.selectedDetentIdentifier = .large
                    }
                }
            }
        }
    }
    
    init(coordinator: Coordinator, hideDetail: Bool = true) {
        self.coordinator = coordinator
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
        
        if sheetPresentationController.selectedDetentIdentifier == .medium {
            hideDetail = true
        }
    }
}
