//
//  ScheduleViewModel.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 09/08/23.
//

import Foundation

protocol ScheduleViewModel: ObservableObject {
    var nearestSchedule: String? { get set }
    var estimatedTimeArrival: String? { get set }
}
