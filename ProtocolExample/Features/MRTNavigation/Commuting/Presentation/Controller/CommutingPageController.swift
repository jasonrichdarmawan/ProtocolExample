//
//  CommutingPageController.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 25/08/23.
//

import UIKit

final class CommutingPageController: Controller {
    private let id: UUID
    
    var coordinator: Coordinator?
    weak var viewController: UIViewController?
    
    private weak var pageVM: (any CommutingPageViewModel)?
    
    init(id: UUID = UUID(), coordinator: Coordinator? = nil) {
        self.id = UUID()
        self.coordinator = coordinator
    }
    
    func loadView() -> Bool {
        let pageVM = CommutingPageViewModelImpl(controller: self)
        self.pageVM = pageVM
        
        let view = CommutingPage(pageVM: pageVM)
        let viewController = HostingController(rootView: view)
        self.viewController = viewController
        
        coordinator?.navigationController.pushViewController(viewController, animated: true)
        return true
    }
}
