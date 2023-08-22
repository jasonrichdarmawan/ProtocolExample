//
//  MRTTrainScheduleImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import Foundation

final class MRTTrainScheduleImpl: MRTTrainSchedule {
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
    
    func get(departure: Station, arrival: Station, departAt: Date = .now) -> [Platform : Schedule] {
        return [:]
    }
}
