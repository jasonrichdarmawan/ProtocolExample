//
//  MRTTrainScheduleManager.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/08/23.
//

import Foundation

final class MRTTrainScheduleManager {
    fileprivate init() {}
    
    static weak var shared: MRTTrainSchedule! {
        get {
            var temp: MRTTrainSchedule
            
            if sharedClosure == nil {
                temp = MRTTrainScheduleImpl.shared
                sharedClosure = temp
            }
            
            return sharedClosure
        }
    }
    
    static weak var sharedClosure: MRTTrainSchedule?
}
