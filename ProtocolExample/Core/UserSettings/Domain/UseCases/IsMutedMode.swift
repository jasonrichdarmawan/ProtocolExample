//
//  GetIsMutedMode.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 26/07/23.
//

import Foundation

protocol IsMutedMode {
    static func get() -> Bool
    /// if return true = success, if return false = failed
    static func set(value: Bool) -> Bool
}
