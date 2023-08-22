//
//  ArrivedAtDestinationSheet.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 22/08/23.
//

import SwiftUI

struct ArrivedAtDestinationSheet<SheetVM: CommutingSheetViewModel>: View {
    @ObservedObject var sheetVM: SheetVM
    
    init(sheetVM: SheetVM) {
        self.sheetVM = sheetVM
    }
    
    var body: some View {
        VStack(spacing: 32) {
            HStack(spacing: 16) {
                Circle()
                    .strokeBorder(.blue, lineWidth: 4)
                    .frame(width: 20, height: 20)
                
                Text("Istora Mandiri").font(.largeTitle)
                
                Spacer()
            }
            
            HStack(spacing: 0) {
                Text("You have arrived at your destination!").font(.largeTitle)
                Spacer()
            }
            
            GIFImage(name: "ArrivedAtDestination")
                .frame(width: 390, height: 201)
            
            Spacer()
            
            Button {
                _ = sheetVM.cancel(animated: true)
            } label: {
                Text("Ok")
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(32)
    }
}

#if DEBUG
struct ArrivedAtDestinationSheet_Previews: PreviewProvider {
    static var previews: some View {
        ArrivedAtDestinationSheet(
            sheetVM: CommutingSheetViewModelImpl(
                coordinator: MRTNavigationCoordinator(
                    navigationController: UINavigationController())))
    }
}
#endif
