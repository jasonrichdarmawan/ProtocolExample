//
//  GetIsMutedMode.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 26/07/23.
//

import Foundation

protocol IsMutedMode: AnyObject {
    func get() -> Bool
    /// if return true = success, if return false = failed
    func set(value: Bool) -> Bool
}
