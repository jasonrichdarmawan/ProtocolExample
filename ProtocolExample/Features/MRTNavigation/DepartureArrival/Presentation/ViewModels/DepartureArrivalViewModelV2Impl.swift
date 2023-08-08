//
//  DepartureArrivalV2ViewModel.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 25/07/23.
//

import SwiftUI

final class DepartureArrivalViewModelV2Impl: DepartureArrivalViewModelImpl {
    override func updateDepartureArrival(value: Station) -> Bool {
        switch departureSelected {
        case true:
            departure = value
        case false:
            arrival = value
        }
        
        return true
    }
}
