//
//  DepartureArrivalLocationViewModelImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/08/23.
//

import UIKit

final class DepartureArrivalLocationViewModelImpl: NSObject, DepartureArrivalLocationViewModel {
    var controller: Controller
    
    var notifyOnceUseCase: NotifyWhenNearMRTStationOnce
    
    init(controller: Controller, notifyOnceUseCase: NotifyWhenNearMRTStationOnce = NotifyWhenNearMRTStationOnceManager.shared) {
        self.controller = controller
        self.notifyOnceUseCase = notifyOnceUseCase
        
        super.init()
        
        self.notifyOnceUseCase.delegate = self
        
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    deinit {
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    func start() -> NotifyWhenNearMRTStationOnceStartEvent {
        return notifyOnceUseCase.start()
    }
}

extension DepartureArrivalLocationViewModelImpl: NotifyWhenNearMRTStationOnceDelegate {
    func notifyManager(_ manager: NotifyWhenNearMRTStationOnce, didFind station: Station) {
        guard let controller = controller as? DepartureArrivalSheetController else { return }
        
        _ = controller.updateDeparture(newValue: station)
    }
}
