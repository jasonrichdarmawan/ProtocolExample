//
//  CommutingPageViewModelImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 31/07/23.
//

import Foundation

class CommutingPageViewModelImpl: CommutingPageViewModel {
    private var controller: Controller?
    
    init(controller: Controller? = nil) {
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
    
    func nextPage() -> Bool {
        guard let coordinator = controller?.coordinator else { return false }
        return coordinator.showRoute(MRTNavigationRoute.CommutingSheet)
    }
}
