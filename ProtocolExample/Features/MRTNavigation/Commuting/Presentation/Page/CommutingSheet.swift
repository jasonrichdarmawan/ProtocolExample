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
                        
                        createRemainingStationRow(hideDetail: sheetVM.hideDetail)
                        
                        createDottedLineRow()
                        
                        createDestinationStationRow()
                    }
                    
                    ChevronView(isUp: $sheetVM.hideDetail)
                }
            }
            
            Button {
                
            } label: {
                Text("Cancel")
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(.horizontal, 32)
    }
}

// MARK: Component
extension CommutingSheet {
    private func createCircleBlue() -> some View {
        Circle()
            .strokeBorder(.blue, lineWidth: 4)
            .frame(width: 20, height: 20)
            .frame(maxWidth: 20, maxHeight: .infinity)
    }
    
    private func createCircleGray() -> some View {
        Circle()
            .foregroundColor(.gray)
            .frame(width: 16, height: 16)
            .frame(maxWidth: 20, maxHeight: .infinity)
    }
    
    private func createTime(_ key: LocalizedStringKey) -> some View {
        Text(key).font(.body)
    }
    
    private func createInfoBody(_ key: LocalizedStringKey) -> some View {
        Text(key)
            .font(.body)
    }
    
    private func createInfoLargeTitle(_ key: LocalizedStringKey) -> some View {
        Text(key)
            .font(.largeTitle)
            .fixedSize(horizontal: true, vertical: false)
    }
}

// MARK: Row
extension CommutingSheet {
    private func createInfoRow(_ key: LocalizedStringKey) -> some View {
        GridRow(alignment: .center) {
            Text("").gridCellUnsizedAxes([.horizontal, .vertical])
            Text("").gridCellUnsizedAxes([.horizontal, .vertical])
            createInfoBody(key)
        }
    }
    
    private func createCurrentStationRow() -> some View {
        Group {
            createInfoRow("Current Station")
            GridRow(alignment: .center) {
                createTime("10:00")
                createCircleBlue()
                createInfoLargeTitle("Lebak Bulus")
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
    
    private func createRemainingStationRow(hideDetail: Bool) -> some View {
        Group {
            if hideDetail {
                createDottedLineRow()
                
                GridRow(alignment: .center) {
                    Text("").gridCellUnsizedAxes([.horizontal, .vertical])
                    createCircleGray()
                    createInfoBody("5 station")
                }
            } else {
                // TODO: dynamic view
                createDottedLineRow()
                
                GridRow(alignment: .center) {
                    createTime("10:05")
                    createCircleGray()
                    createInfoBody("Fatmawati")
                }
                
                createDottedLineRow()
                
                GridRow(alignment: .center) {
                    createTime("10:15")
                    createCircleGray()
                    createInfoBody("Cipete Raya")
                }
                
                createDottedLineRow()
                
                GridRow(alignment: .center) {
                    createTime("10:25")
                    createCircleGray()
                    createInfoBody("Haji Nawi")
                }
                
                createDottedLineRow()
                
                GridRow(alignment: .center) {
                    createTime("10:30")
                    createCircleGray()
                    createInfoBody("Blok A")
                }
                
                createDottedLineRow()
                
                GridRow(alignment: .center) {
                    createTime("10:35")
                    createCircleGray()
                    createInfoBody("Blok M")
                }
            }
        }
    }
    
    private func createDestinationStationRow() -> some View {
        Group {
            GridRow(alignment: .center) {
                createTime("10:45")
                createCircleBlue()
                createInfoLargeTitle("Istora Mandiri")
            }
            createInfoRow("Destination Station")
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
                .presentationDetents([.height(390), .large])
                .presentationBackgroundInteraction(.enabled)
        }
        .environment(\.locale, .init(identifier: "id-ID"))
    }
}
#endif
