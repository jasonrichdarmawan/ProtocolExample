//
//  Station.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/07/23.
//

import Foundation

struct Station {
    let name, acronym: String
    
    // for Bluetooth
    let major: UInt16
}

// ForEach
extension Station: Identifiable {
    var id: String { name }
}

// Comparison
extension Station: Equatable {}
