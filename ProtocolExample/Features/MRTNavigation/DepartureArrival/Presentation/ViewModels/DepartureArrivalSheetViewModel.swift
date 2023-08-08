//
//  DepartureArrivalPageViewModel.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 01/08/23.
//

import SwiftUI

protocol DepartureArrivalSheetViewModel: NSObjectProtocol, ObservableObject, UISheetPresentationControllerDelegate {
    var selectMRTStationNotPresentedDetent: UISheetPresentationController.Detent { get }
    var selectMRTStationNotPresentedDetentIdentifier: UISheetPresentationController.Detent.Identifier { get }
    
    var isSelectMRTStationPresented: Bool { get set }
}
