//
//  CommutingSheetViewModelImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 18/08/23.
//

import SwiftUI
import UIKit

final class CommutingSheetViewModelImpl: CommutingSheetViewModel {
    var coordinator: Coordinator
    
    @Published var state: CommutingSheetState {
        willSet {
            switch newValue {
            case .DetailSheet: _ = presentDetailSheet()
            case .ArrivedAtDestinationSheet: _ = presentArrivedAtDestinationSheet()
            }
        }
    }
    
    init(
        coordinator: Coordinator,
        state: CommutingSheetState = .DetailSheet
    ) {
        self.coordinator = coordinator
        self.state = .DetailSheet
    }
    
    func cancel(animated: Bool) -> Bool {
        guard coordinator.dismiss(animated: animated) else { return false }
        return coordinator.popViewController(animated: animated)
    }
}

extension CommutingSheetViewModelImpl {
    private func presentDetailSheet() -> Bool {
        guard let coordinator = coordinator as? MRTNavigationCoordinator else { return false }
        
        guard let sheetController = coordinator.commutingSheetVC?.sheetPresentationController else { return false }
        
        sheetController.animateChanges {
            sheetController.selectedDetentIdentifier = .medium
        }
        
        return true
    }
    
    private func presentArrivedAtDestinationSheet() -> Bool {
        guard let coordinator = coordinator as? MRTNavigationCoordinator else { return false }
        
        guard let sheetController = coordinator.commutingSheetVC?.sheetPresentationController else { return false }
        
        sheetController.animateChanges {
            sheetController.selectedDetentIdentifier = .large
        }
        
        return true
    }
}
