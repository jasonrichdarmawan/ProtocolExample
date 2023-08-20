//
//  CommutingSheet.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 18/08/23.
//

import SwiftUI

struct CommutingSheet<SheetVM: CommutingSheetViewModel>: ViewControllable {
    @ObservedObject var sheetVM: SheetVM
    
    init(sheetVM: SheetVM) {
        self.sheetVM = sheetVM
    }
    
    var body: some View {
        VStack(spacing: 32) {
            Capsule()
                .fill(Color.secondary)
                .frame(width: 40, height: 4)
                .padding(.top, 8)
            
            ScrollView {
                HStack(alignment: .top, spacing: 16) {
                    Grid(alignment: .leadingFirstTextBaseline, horizontalSpacing: 16, verticalSpacing: 4) {
                        createCurrentStationRow()
                        
                        createDottedLineRow()
                        
                        createRemainingStationRow()
                        
                        createDottedLineRow()
                        
                        createDestinationStationRow()
                    }
                    
                    ChevronView(isUp: $sheetVM.hideDetail)
                }
            }
        }
        .padding(.horizontal, 32)
    }
}

extension CommutingSheet {
    private func createCurrentStationRow() -> some View {
        Group {
            GridRow(alignment: .center) {
                Text("").gridCellUnsizedAxes([.horizontal, .vertical])
                Text("").gridCellUnsizedAxes([.horizontal, .vertical])
                Text("Current Station")
            }
            GridRow(alignment: .center) {
                Text("10:00").font(.body)
                Circle()
                    .strokeBorder(.blue, lineWidth: 4)
                    .frame(width: 20, height: 20)
                    .frame(maxWidth: 20)
                Text("Lebak Bulus")
                    .font(.largeTitle)
                    .fixedSize(horizontal: true, vertical: false)
            }
        }
    }
    
    private func createDottedLineRow() -> some View {
        GridRow(alignment: .center) {
            Text("").gridCellUnsizedAxes([.horizontal, .vertical])
            Line()
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [16, 8]))
                .foregroundColor(.gray)
                .frame(height: 40)
                .frame(maxWidth: 20)
            Text("").gridCellUnsizedAxes([.horizontal, .vertical])
        }
    }
    
    private func createRemainingStationRow() -> some View {
        GridRow(alignment: .center) {
            Text("").gridCellUnsizedAxes([.horizontal, .vertical])
            Circle()
                .foregroundColor(.gray)
                .frame(width: 16, height: 16)
                .frame(maxWidth: 20, maxHeight: 22)
            Text("5 station").font(.body)
        }
    }
    
    private func createDestinationStationRow() -> some View {
        Group {
            GridRow(alignment: .center) {
                Text("10:45").font(.body)
                Circle()
                    .strokeBorder(.blue, lineWidth: 4)
                    .frame(width: 20, height: 20)
                    .frame(maxWidth: 20)
                Text("Istora Mandiri")
                    .font(.largeTitle)
                    .fixedSize(horizontal: true, vertical: false)
            }
            GridRow(alignment: .center) {
                Text("").gridCellUnsizedAxes([.horizontal, .vertical])
                Text("").gridCellUnsizedAxes([.horizontal, .vertical])
                Text("Destination Station")
            }
        }
    }
}

#if DEBUG
struct CommutingSheet_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CommutingPage(
                pageVM: CommutingPageViewModelImpl(
                    coordinator: MRTNavigationCoordinator(
                        navigationController: UINavigationController())))
        }
        .sheet(isPresented: .constant(true)) {
            CommutingSheet(sheetVM: CommutingSheetViewModelImpl(
                coordinator: MRTNavigationCoordinator(navigationController: UINavigationController())))
                .presentationDetents([.medium, .large])
        }
        .environment(\.locale, .init(identifier: "id-ID"))
    }
}
#endif
