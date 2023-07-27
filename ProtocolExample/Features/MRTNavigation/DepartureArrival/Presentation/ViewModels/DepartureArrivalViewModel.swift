//
//  DepartureArrivalViewModel.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 27/07/23.
//

import Foundation

protocol DepartureArrivalViewModel: ObservableObject {
    var departure: Station? { get set }
    var arrival: Station? { get set }
    var departureSelected: Bool { get set }
    var arrivalSelected: Bool { get set }
    
    func updateDepartureArrival(value: Station) -> Bool
    func isDepartureArrivalNotNil() -> Bool
}
