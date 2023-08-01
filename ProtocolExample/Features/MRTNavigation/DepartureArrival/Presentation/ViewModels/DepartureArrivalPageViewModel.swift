//
//  DepartureArrivalPageViewModel.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 01/08/23.
//

import SwiftUI

enum DepartureArrivalPageState {
    case PRESENT_SHEET
    case PRESENT_NAVIGATION_DESTINATION
    
    case DISMISS
}

protocol DepartureArrivalPageViewModel: ObservableObject {
    var state: DepartureArrivalPageState { get }
    var isSheetPresented: Bool { get set }
    var isNavigationDestinationPresented: Bool { get set }
    
    var selectedDetent: PresentationDetent { get set }
    
    func sheetDidDismiss(_ dismiss: DismissAction) -> Bool
    
    func navigationDestinationDidDisappear() -> Bool
}
