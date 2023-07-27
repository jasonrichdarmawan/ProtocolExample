//
//  NextScheduleEstimatedTimeArrival.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 27/07/23.
//

import SwiftUI

final class NextScheduleEstimatedTimeArrivalViewModel: ObservableObject {
    @Published var nearestSchedule: String?
    @Published var estimatedTimeArrival: String?
    
    init(nearestSchedule: String? = nil, estimatedTimeArrival: String? = nil) {
        self.nearestSchedule = nearestSchedule
        self.estimatedTimeArrival = estimatedTimeArrival
    }
    
}

struct NextScheduleEstimatedTimeArrivalView: View {
    @ObservedObject var viewModel: NextScheduleEstimatedTimeArrivalViewModel
    
    init(viewModel: NextScheduleEstimatedTimeArrivalViewModel = NextScheduleEstimatedTimeArrivalViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(spacing: 40) {
            VStack(spacing: 8) {
                Text("Nearest\nSchedule")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                Text((viewModel.nearestSchedule != nil) ? "\(viewModel.nearestSchedule!)" : "-")
                    .font(.headline)
            }
            .frame(maxWidth: 83)
            
            Line()
                .stroke(style: StrokeStyle(lineWidth: 1))
                .foregroundColor(Color("schedule_line"))
                .frame(width: 1, height: 56)
            
            VStack(spacing: 8) {
                Text("Estimated\nTime of Arrival")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                Text((viewModel.estimatedTimeArrival != nil) ? "\(viewModel.estimatedTimeArrival!)" : "-")
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
struct NextScheduleEstimatedTimeArrivalView_Previews: PreviewProvider {
    static var previews: some View {
        NextScheduleEstimatedTimeArrivalView(viewModel: NextScheduleEstimatedTimeArrivalViewModel(nearestSchedule: "10:00", estimatedTimeArrival: "12:00"))
            .environment(\.locale, .init(identifier: "id-ID"))
    }
}
#endif
