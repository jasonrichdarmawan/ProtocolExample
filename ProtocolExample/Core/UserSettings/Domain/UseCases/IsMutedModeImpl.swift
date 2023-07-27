//
//  GetIsMutedModeImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 26/07/23.
//

import Foundation

final class IsMutedModeImpl: IsMutedMode {
    fileprivate init() {}
    
    static func get() -> Bool {
        return UserDefaults.standard.bool(forKey: "isMutedMode")
    }
    
    static func set(value: Bool) -> Bool {
        UserDefaults.standard.set(value, forKey: "isMutedMode")
        
        return true
    }
}
