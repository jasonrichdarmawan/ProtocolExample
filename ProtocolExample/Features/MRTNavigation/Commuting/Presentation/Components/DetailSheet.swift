//
//  DetailSheet.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 18/08/23.
//

import SwiftUI

struct DetailSheet<
    SheetVM: CommutingSheetViewModel,
    DetailVM: CommutingDetailViewModel
>: View {
    @ObservedObject var sheetVM: SheetVM
    @ObservedObject var detailVM: DetailVM
    
    init(sheetVM: SheetVM, detailVM: DetailVM) {
        self.sheetVM = sheetVM
        self.detailVM = detailVM
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                HStack(alignment: .top, spacing: 16) {
                    Grid(alignment: .leadingFirstTextBaseline, horizontalSpacing: 16, verticalSpacing: 4) {
                        createCurrentStationRow()
                        
                        createRemainingStationRow(hideDetail: detailVM.hideDetail)
                        
                        createDottedLineRow()
                        
                        createDestinationStationRow()
                    }
                    
                    Spacer()
                    
                    ChevronView(isUp: $detailVM.hideDetail)
                }
            }
            
            Button {
                _ = sheetVM.cancel(animated: true)
            } label: {
                Text("Cancel")
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(32)
        .onAppear {
            _ = detailVM.setAsDelegate()
        }
    }
}

// MARK: Component
extension DetailSheet {
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
extension DetailSheet {
    private func createInfoRow(_ key: LocalizedStringKey) -> some View {
        GridRow(alignment: .center) {
//            Text("").gridCellUnsizedAxes([.horizontal, .vertical])
            Text("").gridCellUnsizedAxes([.horizontal, .vertical])
            createInfoBody(key)
        }
    }
    
    private func createCurrentStationRow() -> some View {
        Group {
            createInfoRow("Current Station")
            GridRow(alignment: .center) {
//                createTime("10:00")
                createCircleBlue()
                createInfoLargeTitle("Lebak Bulus")
            }
        }
    }
    
    private func createDottedLineRow() -> some View {
        GridRow(alignment: .center) {
//            Text("").gridCellUnsizedAxes([.horizontal, .vertical])
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
//                    Text("").gridCellUnsizedAxes([.horizontal, .vertical])
                    createCircleGray()
                    createInfoBody("5 station")
                }
            } else {
                // TODO: dynamic view
                createDottedLineRow()
                
                GridRow(alignment: .center) {
//                    createTime("10:05")
                    createCircleGray()
                    createInfoBody("Fatmawati")
                }
                
                createDottedLineRow()
                
                GridRow(alignment: .center) {
//                    createTime("10:15")
                    createCircleGray()
                    createInfoBody("Cipete Raya")
                }
                
                createDottedLineRow()
                
                GridRow(alignment: .center) {
//                    createTime("10:25")
                    createCircleGray()
                    createInfoBody("Haji Nawi")
                }
                
                createDottedLineRow()
                
                GridRow(alignment: .center) {
//                    createTime("10:30")
                    createCircleGray()
                    createInfoBody("Blok A")
                }
                
                createDottedLineRow()
                
                GridRow(alignment: .center) {
//                    createTime("10:35")
                    createCircleGray()
                    createInfoBody("Blok M")
                }
            }
        }
    }
    
    private func createDestinationStationRow() -> some View {
        Group {
            GridRow(alignment: .center) {
//                createTime("10:45")
                createCircleBlue()
                createInfoLargeTitle("Istora Mandiri")
            }
            createInfoRow("Destination Station")
        }
    }
}

#if DEBUG
struct CommutingSheetExample: View {
    @StateObject private var pageVM = CommutingPageViewModelImpl()
    @StateObject private var sheetVM = CommutingSheetViewModelImpl()
    @StateObject private var detailVM = CommutingDetailViewModelImpl()
    
    var body: some View {
        VStack {
            CommutingPage(pageVM: pageVM)
        }
        .sheet(isPresented: .constant(true)) {
            DetailSheet(sheetVM: sheetVM, detailVM: detailVM)
            .presentationDetents([.height(390), .large])
            .presentationBackgroundInteraction(.enabled)
        }
        .environment(\.locale, .init(identifier: "id-ID"))
    }
}

struct CommutingSheet_Previews: PreviewProvider {
    static var previews: some View {
        CommutingSheetExample()
    }
}
#endif
