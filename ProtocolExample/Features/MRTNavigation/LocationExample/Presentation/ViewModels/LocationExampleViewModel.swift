//
//  LocationExampleViewModel.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 22/08/23.
//

import Foundation

protocol LocationExampleViewModel: ObservableObject {
    var station: Station? { get set }
    
    func start() -> NotifyWhenNearMRTStationOnceStartEvent
}
