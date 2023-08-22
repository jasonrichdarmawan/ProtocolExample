//
//  GetIsMutedModeImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 26/07/23.
//

import Foundation

final class IsMutedModeImpl: IsMutedMode {
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
    
    func get() -> Bool {
        return UserDefaults.standard.bool(forKey: "isMutedMode")
    }
    
    func set(value: Bool) -> Bool {
        UserDefaults.standard.set(value, forKey: "isMutedMode")
        
        return true
    }
}

extension IsMutedModeImpl {
    static var shared: IsMutedMode! {
        get {
            var temp: IsMutedMode
            
            if sharedClosure == nil {
                temp = IsMutedModeImpl()
                sharedClosure = temp
            }
            
            return sharedClosure
        }
    }
    
    private static weak var sharedClosure: IsMutedMode?
}
