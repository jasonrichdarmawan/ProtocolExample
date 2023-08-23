//
//  DepartureArrivalLocationViewModel.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/08/23.
//

import Foundation

protocol DepartureArrivalLocationViewModel: ObservableObject {
    func start() -> NotifyWhenNearMRTStationOnceStartEvent
}
