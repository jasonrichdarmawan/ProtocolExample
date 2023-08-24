//
//  DepartureArrivalPageController.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 25/08/23.
//

import UIKit

final class DepartureArrivalPageController: Controller {
    private var id: UUID
    
    var coordinator: Coordinator?
    weak var viewController: UIViewController?
    
    private weak var pageVM: (any DepartureArrivalPageViewModel)?
    
    init(id: UUID = UUID(), coordinator: Coordinator? = nil) {
        self.id = id
        self.coordinator = coordinator
    }
    
    func loadView() -> Bool {
        let pageVM = DepartureArrivalPageViewModelImpl(controller: self)
        self.pageVM = pageVM
        
        let view = DepartureArrivalPage(pageVM: pageVM)
        let viewController = HostingController(rootView: view)
        self.viewController = viewController
        
        coordinator?.navigationController.pushViewController(viewController, animated: true)
        return true
    }
}
