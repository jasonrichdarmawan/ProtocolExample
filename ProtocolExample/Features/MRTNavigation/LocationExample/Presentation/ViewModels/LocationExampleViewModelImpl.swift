//
//  LocationExampleViewModelImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 22/08/23.
//

import Foundation

final class LocationExampleViewModelImpl: LocationExampleViewModel {
    var controller: Controller?
    
    @Published var station: Station?
    
    private var notifyOnceUseCase: NotifyWhenNearMRTStationOnce
    
    init(
        controller: Controller? = nil,
        notifyOnceUseCase: NotifyWhenNearMRTStationOnce = NotifyWhenNearMRTStationOnceManager.shared
    ) {
        self.controller = controller
        self.notifyOnceUseCase = notifyOnceUseCase
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

extension LocationExampleViewModelImpl: NotifyWhenNearMRTStationOnceDelegate {
    func notifyManager(_ manager: NotifyWhenNearMRTStationOnce, didFind station: Station) {
        self.station = station
    }
}
