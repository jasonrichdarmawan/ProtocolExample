//
//  DepartureArrivalViewModel.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 25/07/23.
//

import SwiftUI

final class DepartureArrivalViewModel: ObservableObject {
    @Published var departure: Station?
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
    
    init(departure: Station? = MRT.LebakBulusGrab.station, arrival: Station? = nil, departureSelected: Bool = false) {
        self.departure = departure
        self.arrival = arrival
        self.departureSelected = departureSelected
    }
    
    func updateDepartureArrival(value: Station) {
        switch departureSelected {
        case true:
            // arrival value: Lebak Bulus Grab Station
            // use case: user want to go from Lebak Bulus Grab Station
            if arrival == value {
                departure = value
                arrival = nil
                return
            }
            
            departure = value
        case false:
            // departure value: Lebak Bulus Grab Station
            // use case: user want to go from Dukuh Atas BNI Station to Lebak Bulus Grab
            if departure == value {
                departure = nil
                arrival = value
                return
            }
            
            arrival = value
        }
    }
    
    func isDepartureArrivalNotNil() -> Bool {
        if departure == nil { return false }
        if arrival == nil { return false }
        
        return true
    }
}
