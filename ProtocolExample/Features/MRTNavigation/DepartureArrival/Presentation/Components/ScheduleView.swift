//
//  ScheduleView.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import SwiftUI

struct ScheduleView: View {
    @Binding var nearestSchedule: String?
    @Binding var estimatedTimeArrival: String?
    
    init(nearestSchedule: Binding<String?>, estimatedTimeArrival: Binding<String?>) {
        self._nearestSchedule = nearestSchedule
        self._estimatedTimeArrival = estimatedTimeArrival
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            
            VStack(spacing: 0) {
                Text("Nearest Schedule")
                    .font(.body)
                    .multilineTextAlignment(.center)
                Text("\(nearestSchedule ?? "-")")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 12)
            
            Spacer()
            Divider()
            Spacer()
            
            VStack(spacing: 0) {
                Text("Estimated Time Arrival")
                    .font(.body)
                    .multilineTextAlignment(.center)
                Text("\(estimatedTimeArrival ?? "-")")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 12)
            
            Spacer()
        }
        .background(Color("ScheduleBackground"))
        .cornerRadius(8)
        .frame(maxHeight: 96)
    }
}

#if DEBUG
private struct ScheduleViewExample: View {
    @State private var nearestSchedule: String?
    @State private var estimatedTimeArrival: String?
    
    var body: some View {
        VStack {
            ScheduleView(nearestSchedule: $nearestSchedule, estimatedTimeArrival: $estimatedTimeArrival)
                .padding(.horizontal, 32)
            
            Button {
                nearestSchedule = "10:00"
            } label: {
                Text("Change Nearest Schedule to 10:00")
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                estimatedTimeArrival = "12:00"
            } label: {
                Text("Change Estimated Time Arrival to 12:00")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleViewExample()
            .environment(\.locale, .init(identifier: "id-ID"))
    }
}
#endif
