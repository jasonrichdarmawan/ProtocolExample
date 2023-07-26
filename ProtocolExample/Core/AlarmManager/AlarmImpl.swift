//
//  AlarmManagerImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import Foundation

final class AlarmImpl: Alarm {
    fileprivate init() {}
    
    func play() -> Bool {
        return true
    }
    
    func stop() -> Bool {
        return true
    }
}

extension AlarmImpl {
    static var shared: AlarmImpl! {
        get {
            if sharedClosure == nil {
                sharedClosure = AlarmImpl()
            }
            
            return sharedClosure
        }
        set {
            sharedClosure = newValue
        }
    }
    
    private static var sharedClosure: AlarmImpl!
}
