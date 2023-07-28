//
//  DepartureArrivalPageViewModel.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 28/07/23.
//

import SwiftUI

final class DepartureArrivalPageViewModel: ObservableObject {
    @Published var isPresented: Bool
    var presentCommutingView: Bool {
        get {
            !isPresented
        }
        set {
            isPresented = !newValue
        }
    }
    
    @Published var selection: PresentationDetent
    
    init(isPresented: Bool = true, selectedDetent: PresentationDetent = .header) {
        self.isPresented = isPresented
        self.selection = selectedDetent
    }
}
