//
//  DepartureArrivalPageViewModel.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 28/07/23.
//

import SwiftUI

class DepartureArrivalPageViewModelImpl: DepartureArrivalPageViewModel {
    @Published private(set) var state: DepartureArrivalPageState
    
    var isSheetPresented: Bool {
        get {
            state == .PRESENT_SHEET
        }
        set {
            if newValue {
                state = .PRESENT_SHEET
            }
        }
    }
    
    var isNavigationDestinationPresented: Bool {
        get {
            state == .PRESENT_NAVIGATION_DESTINATION
        }
        set {
            if newValue {
                state = .PRESENT_NAVIGATION_DESTINATION
            }
        }
    }
    
    @Published var selectedDetent: PresentationDetent
    
    init(state: DepartureArrivalPageState = .PRESENT_SHEET, selectedDetent: PresentationDetent = .header) {
        self.state = state
        self.selectedDetent = selectedDetent
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    deinit {
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
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
