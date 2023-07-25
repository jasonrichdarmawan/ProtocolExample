//
//  DepartureArrivalV2ViewModel.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 25/07/23.
//

import SwiftUI

final class DepartureArrivalV2ViewModel: ObservableObject {
    @Published var departure: Station
    @Published var arrival: Station?
    
    @Published var departureSelected: Bool
    var arrivalSelected: Bool {
        get {
            return !departureSelected
        }
        set {
            departureSelected = !newValue
        }
    }
    
    init(departure: Station = MRT.LebakBulusGrab.station, arrival: Station? = nil, departureSelected: Bool = false) {
        self.departure = departure
        self.arrival = arrival
        self.departureSelected = departureSelected
    }
    
    func updateDepartureArrival(value: Station) {
        switch departureSelected {
        case true:
            // swap
            if arrival == value {
                arrival = departure
            }
            
            departure = value
        case false:
            // swap
            if departure == value {
                if let arrival {
                    departure = arrival
                }
            }
            
            arrival = value
        }
    }
}
