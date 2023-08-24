//
//  CommutingSheetViewModelImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 18/08/23.
//

import SwiftUI
import UIKit

final class CommutingSheetViewModelImpl: CommutingSheetViewModel {
    var controller: Controller?
    
    @Published var state: CommutingSheetState {
        willSet {
            switch newValue {
            case .DetailSheet: _ = presentDetailSheet()
            case .ArrivedAtDestinationSheet: _ = presentArrivedAtDestinationSheet()
            }
        }
    }
    
    init(
        controller: Controller? = nil,
        state: CommutingSheetState = .DetailSheet
    ) {
        self.controller = controller
        self.state = .DetailSheet
    }
    
    func cancel(animated: Bool) -> Bool {
        guard let coordinator = controller?.coordinator else { return false }
        guard coordinator.dismiss(animated: animated) else { return false }
        return coordinator.popViewController(animated: animated)
    }
}

extension CommutingSheetViewModelImpl {
    private func presentDetailSheet() -> Bool {
        guard let sheetController = controller?.viewController?.sheetPresentationController else { return false }
        
        sheetController.animateChanges {
            sheetController.selectedDetentIdentifier = .medium
        }
        
        return true
    }
    
    private func presentArrivedAtDestinationSheet() -> Bool {
        guard let sheetController = controller?.viewController?.sheetPresentationController else { return false }
        
        sheetController.animateChanges {
            sheetController.selectedDetentIdentifier = .large
        }
        
        return true
    }
}
