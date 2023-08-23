//
//  MRTTrainScheduleImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import Foundation

final class MRTTrainScheduleImpl: MRTTrainSchedule {
    fileprivate init() {
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

extension MRTTrainScheduleImpl {
    static weak var shared: MRTTrainSchedule! {
        get {
            var temp: MRTTrainSchedule
            
            if sharedClosure == nil {
                temp = MRTTrainScheduleImpl()
                sharedClosure = temp
            }
            
            return sharedClosure
        }
    }
    
    private static weak var sharedClosure: MRTTrainSchedule?
}
