//
//  CommutingSheet.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 22/08/23.
//

import SwiftUI

struct CommutingSheet<
    SheetVM: CommutingSheetViewModel,
    DetailVM: CommutingDetailViewModel
>: ViewControllable {
    @ObservedObject var sheetVM: SheetVM
    @ObservedObject var detailVM: DetailVM
    
    init(sheetVM: SheetVM, detailVM: DetailVM) {
        self.sheetVM = sheetVM
        self.detailVM = detailVM
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Capsule()
                .fill(Color.secondary)
                .frame(width: 40, height: 4)
                .padding(.top, 8)
            
            switch sheetVM.state {
            case .DetailSheet:
                DetailSheet(sheetVM: sheetVM, detailVM: detailVM)
            case .ArrivedAtDestinationSheet:
                ArrivedAtDestinationSheet(sheetVM: sheetVM)
            }
        }
    }
}
