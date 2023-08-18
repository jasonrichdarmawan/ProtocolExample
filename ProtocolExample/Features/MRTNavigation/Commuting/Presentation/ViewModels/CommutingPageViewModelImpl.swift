//
//  CommutingPageViewModelImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 31/07/23.
//

import Foundation

class CommutingPageViewModelImpl: CommutingPageViewModel {
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
        return coordinator.showRoute(MRTNavigationRoute.CommutingSheet)
    }
}
