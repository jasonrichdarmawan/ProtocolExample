//
//  DepartureArrivalLocationViewModelImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/08/23.
//

import Foundation

final class DepartureArrivalLocationViewModelImpl: NSObject, DepartureArrivalLocationViewModel {
    var coordinator: Coordinator
    
    var notifyOnceUseCase: NotifyWhenNearMRTStationOnce
    
    init(coordinator: Coordinator, notifyOnceUseCase: NotifyWhenNearMRTStationOnce) {
        self.coordinator = coordinator
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
        guard let coordinator = coordinator as? MRTNavigationCoordinator else { return }
        
        _ = coordinator.updateDeparture(newValue: station)
    }
}
