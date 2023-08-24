//
//  DetailSheetViewModelImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 22/08/23.
//

import UIKit

final class CommutingDetailViewModelImpl: NSObject, CommutingDetailViewModel {
    var controller: Controller?
    
    var hideDetailDetent: UISheetPresentationController.Detent
    var hideDetailDetentIdentifier: UISheetPresentationController.Detent.Identifier
    
    @Published var hideDetail: Bool {
        didSet {
            guard let sheetController = controller?.viewController?.sheetPresentationController else { return }
            
            sheetController.animateChanges {
                if hideDetail {
                    sheetController.selectedDetentIdentifier = hideDetailDetentIdentifier
                } else {
                    sheetController.selectedDetentIdentifier = .large
                }
            }
        }
    }
    
    init(
        controller: Controller? = nil,
        hideDetailDetent: UISheetPresentationController.Detent = .custom(
            identifier: .init("hideDetailDetent"),
            resolver: { context in 390 }),
        hideDetailDetentIdentifier: UISheetPresentationController.Detent.Identifier = .init("hideDetailDetent"),
        hideDetail: Bool = true
    ) {
        self.controller = controller
        self.hideDetailDetent = hideDetailDetent
        self.hideDetailDetentIdentifier = hideDetailDetentIdentifier
        self.hideDetail = hideDetail
    }
    
    func setAsDelegate() -> Bool {
        guard let sheetController = controller?.viewController?.sheetPresentationController else { return false }
        
        sheetController.delegate = self
        
        return true
    }
}

extension CommutingDetailViewModelImpl: UISheetPresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        _ = controller?.coordinator?.navigationController.popViewController(animated: true)
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
