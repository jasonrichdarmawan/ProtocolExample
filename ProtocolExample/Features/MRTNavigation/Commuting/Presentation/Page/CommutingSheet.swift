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
            Text("Commuting Sheet")
            
            Spacer()
        }
        .padding(.horizontal, 32)
    }
}
