//
//  DepartureArrivalPageViewModel.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 28/07/23.
//

import SwiftUI

enum DepartureArrivalPageState {
    case PRESENT_SHEET
    case PRESENT_NAVIGATION_DESTINATION
    
    case DISMISS
}

final class DepartureArrivalPageViewModel: ObservableObject {
    @Published var state: DepartureArrivalPageState
    var presentSheet: Bool {
        get {
            state == .PRESENT_SHEET
        }
        set {
            if newValue {
                state = .PRESENT_SHEET
            }
        }
    }
    var presentNavigationDestination: Bool {
        get {
            state == .PRESENT_NAVIGATION_DESTINATION
        }
        set {
            if newValue {
                state = .PRESENT_NAVIGATION_DESTINATION
            }
        }
    }
    
    @Published var selection: PresentationDetent
    
    init(state: DepartureArrivalPageState = .PRESENT_SHEET, selectedDetent: PresentationDetent = .header) {
        self.state = state
        self.selection = selectedDetent
    }
    
    func sheetDidDismiss(_ dismiss: DismissAction) -> Bool {
        switch state {
        case .PRESENT_SHEET:
            state = .DISMISS
            dismiss()
        default: break
        }
        
        return true
    }
    
    func navigationDestinationDidDisappear() -> Bool {
        switch state {
        case .PRESENT_NAVIGATION_DESTINATION:
            state = .PRESENT_SHEET
        default: break
        }
        
        return true
    }
}
