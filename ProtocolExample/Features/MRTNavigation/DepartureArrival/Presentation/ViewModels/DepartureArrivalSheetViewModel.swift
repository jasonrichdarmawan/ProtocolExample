//
//  DepartureArrivalPageViewModel.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 01/08/23.
//

import SwiftUI

protocol DepartureArrivalSheetViewModel: ObservableObject {
    var selectMRTStationNotPresentedDetent: UISheetPresentationController.Detent { get }
    var selectMRTStationNotPresentedDetentIdentifier: UISheetPresentationController.Detent.Identifier { get }
    
    var isPresented: Bool { get set }
    
    func nextPage() -> Bool
}
