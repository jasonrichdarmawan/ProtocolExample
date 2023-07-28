//
//  DepartureArrivalPageViewModel.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 28/07/23.
//

import SwiftUI

final class DepartureArrivalPageViewModel: ObservableObject {
    @Published var isPresented: Bool
    @Published var selectedDetent: PresentationDetent
    
    init(isPresented: Bool = true, selectedDetent: PresentationDetent = .header) {
        self.isPresented = isPresented
        self.selectedDetent = selectedDetent
    }
}
