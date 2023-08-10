//
//  DepartureArrivalPageViewModelImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 10/08/23.
//

import Foundation

final class DepartureArrivalPageViewModelImpl: DepartureArrivalPageViewModel {
    private var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    deinit {
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    func nextPage() -> Bool {
        coordinator.showRoute(MRTNavigationRoute.DepartureArrivalSheet)
    }
}
