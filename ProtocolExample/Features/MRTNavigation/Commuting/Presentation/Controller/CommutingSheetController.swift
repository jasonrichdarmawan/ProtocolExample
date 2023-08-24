//
//  CommutingSheetController.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 25/08/23.
//

import UIKit

final class CommutingSheetController: Controller {
    private let id: UUID
    
    var coordinator: Coordinator?
    weak var viewController: UIViewController?
    
    private weak var sheetVM: (any CommutingSheetViewModel)?
    private weak var detailVM: (any CommutingDetailViewModel)?
    
    init(id: UUID = UUID(), coordinator: Coordinator? = nil) {
        self.id = id
        self.coordinator = coordinator
    }
    
    func loadView() -> Bool {
        let sheetVM = CommutingSheetViewModelImpl(controller: self)
        self.sheetVM = sheetVM
        
        let detailVM = CommutingDetailViewModelImpl(controller: self)
        self.detailVM = detailVM
        
        let view = CommutingSheet(sheetVM: sheetVM, detailVM: detailVM)
        let viewController = HostingController(rootView: view)
        self.viewController = viewController
        
        guard let sheetController = viewController.sheetPresentationController else { return false }
        
        sheetController.detents = [detailVM.hideDetailDetent, .large()]
        sheetController.largestUndimmedDetentIdentifier = detailVM.hideDetailDetentIdentifier
        
        coordinator?.navigationController.present(viewController, animated: true)
        return true
    }
}
