//
//  DepartureArrivalPageViewModelImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 10/08/23.
//

import Foundation

final class DepartureArrivalPageViewModelImpl: DepartureArrivalPageViewModel {
    private var controller: Controller
    
    init(controller: Controller) {
        self.controller = controller
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    deinit {
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    func presentSheet() -> Bool {
        guard let coordinator = controller.coordinator else { return false }
        return coordinator.showRoute(MRTNavigationRoute.DepartureArrivalSheet)
    }
}
