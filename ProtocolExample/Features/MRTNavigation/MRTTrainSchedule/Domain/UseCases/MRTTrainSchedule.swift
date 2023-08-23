//
//  MRTTrainSchedule.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import Foundation

protocol MRTTrainSchedule: AnyObject {
    func get(departure: Station, arrival: Station, departAt: Date) -> [Platform: Schedule]
}
