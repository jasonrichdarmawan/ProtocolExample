//
//  MRTTrainScheduleImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import Foundation

final class MRTTrainScheduleImpl: MRTTrainSchedule {
    func get(departure: Station, arrival: Station, departAt: Date = .now) -> [Station.Platform : Train.Schedule] {
        return [:]
    }
}
