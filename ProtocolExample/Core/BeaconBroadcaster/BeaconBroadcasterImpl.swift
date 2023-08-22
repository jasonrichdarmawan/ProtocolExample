//
//  BeaconBroadcasterImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import Foundation

final class BeaconBroadcasterImpl: BeaconBroadcaster {
    init() {
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    deinit {
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    func isAuthorizedOrRequestAuthorization() -> Bool {
        return true
    }
    
    func start(uuid: UUID, major: UInt16, minor: UInt16) -> BeaconBroadcasterStartEvent {
        return .IS_STARTING
    }
    
    func stop() -> BeaconBroadcasterStopEvent {
        return .IS_STOPPING
    }
}
