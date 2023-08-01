//
//  NextScheduleEstimatedTimeArrivalViewModel.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 31/07/23.
//

import Foundation

protocol NextScheduleEstimatedtimeArrivalViewModel: ObservableObject {
    var nearestSchedule: String? { get set }
    var estimatedTimeArrival: String? { get set }
}

class NextScheduleEstimatedTimeArrivalViewModelImpl: NextScheduleEstimatedtimeArrivalViewModel {
    @Published var nearestSchedule: String?
    @Published var estimatedTimeArrival: String?
    
    init(nearestSchedule: String? = nil, estimatedTimeArrival: String? = nil) {
        self.nearestSchedule = nearestSchedule
        self.estimatedTimeArrival = estimatedTimeArrival
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    deinit {
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
}
