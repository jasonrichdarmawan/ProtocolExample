//
//  NextScheduleEstimatedTimeArrival.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 27/07/23.
//

import SwiftUI

struct DepartureArrivalScheduleView<ScheduleVM: DepartureArrivalScheduleViewModel>: View {
    @ObservedObject var scheduleVM: ScheduleVM
    
    init(scheduleVM: ScheduleVM = DepartureArrivalScheduleViewModelImpl()) {
        self.scheduleVM = scheduleVM
    }
    
    var body: some View {
        HStack(spacing: 40) {
            VStack(spacing: 8) {
                Text("Nearest\nSchedule")
                    .foregroundColor(Color("schedule_text"))
                    .font(.caption)
                    .multilineTextAlignment(.center)
                Text((scheduleVM.nearestSchedule != nil) ? "\(scheduleVM.nearestSchedule!)" : "-")
                    .foregroundColor(Color("schedule_text"))
                    .font(.headline)
            }
            .frame(maxWidth: 83)
            
            Line()
                .stroke(style: StrokeStyle(lineWidth: 1))
                .foregroundColor(Color("schedule_line"))
                .frame(width: 1, height: 56)
            
            VStack(spacing: 8) {
                Text("Estimated\nTime of Arrival")
                    .foregroundColor(Color("schedule_text"))
                    .font(.caption)
                    .multilineTextAlignment(.center)
                Text((scheduleVM.estimatedTimeArrival != nil) ? "\(scheduleVM.estimatedTimeArrival!)" : "-")
                    .foregroundColor(Color("schedule_text"))
                    .font(.headline)
            }
            .frame(maxWidth: 83)
        }
        .frame(maxWidth: 328, maxHeight: 62)
        .padding(.vertical, 16)
        .background(Color("schedule_background"))
        .cornerRadius(4)
    }
}

#if DEBUG
struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        DepartureArrivalScheduleView(scheduleVM: DepartureArrivalScheduleViewModelImpl(nearestSchedule: "10:00", estimatedTimeArrival: "12:00"))
            .environment(\.locale, .init(identifier: "id-ID"))
    }
}
#endif
