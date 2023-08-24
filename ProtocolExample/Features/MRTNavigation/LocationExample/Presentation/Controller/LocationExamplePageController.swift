//
//  LocationExamplePageController.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 25/08/23.
//

import UIKit

final class LocationExamplePageController: Controller {
    private let id: UUID
    
    var coordinator: Coordinator?
    weak var viewController: UIViewController?
    
    private weak var locationVM: (any LocationExampleViewModel)?
    
    init(id: UUID = UUID(), coordinator: Coordinator? = nil) {
        self.id = id
        self.coordinator = coordinator
#if DEBUG
        print("\(type(of: self)) \(#function) \(id.uuidString)")
#endif
    }
    
    deinit {
#if DEBUG
        print("\(type(of: self)) \(#function) \(id.uuidString)")
#endif
    }
    
    func loadView() -> Bool {
        let locationVM = LocationExampleViewModelImpl(controller: self)
        self.locationVM = locationVM
        
        let view = LocationExamplePage(locationVM: locationVM)
        let viewController = HostingController(rootView: view)
        self.viewController = viewController
        
        coordinator?.navigationController.pushViewController(viewController, animated: true)
        return true
    }
    
}
