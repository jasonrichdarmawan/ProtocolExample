//
//  DepartureArrivalPageViewModel.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 28/07/23.
//

import SwiftUI

class DepartureArrivalSheetViewModelImpl: NSObject, DepartureArrivalSheetViewModel {
    private var coordinator: Coordinator
    
    var selectMRTStationNotPresentedDetent: UISheetPresentationController.Detent
    var selectMRTStationNotPresentedDetentIdentifier: UISheetPresentationController.Detent.Identifier
    
    @Published var isSelectMRTStationPresented: Bool
    
    init(
        coordinator: Coordinator,
        selectMRTStationNotPresentedDetent: UISheetPresentationController.Detent = .custom(identifier: .init("topPadding105"), resolver: { context in context.maximumDetentValue - 105 }),
        selectMRTStationNotPresentedDetentIdentifier: UISheetPresentationController.Detent.Identifier = .init("topPadding105"),
        isSelectedMRTStationPresented: Bool = false
    ) {
        self.coordinator = coordinator
        self.selectMRTStationNotPresentedDetent = selectMRTStationNotPresentedDetent
        self.selectMRTStationNotPresentedDetentIdentifier = selectMRTStationNotPresentedDetentIdentifier
        self.isSelectMRTStationPresented = isSelectedMRTStationPresented
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    deinit {
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
}

extension DepartureArrivalSheetViewModelImpl {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        _ = coordinator.popRoute(animated: true)
    }
    
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        if sheetPresentationController.selectedDetentIdentifier == .large {
            isSelectMRTStationPresented = true
        }
        
        if sheetPresentationController.selectedDetentIdentifier == selectMRTStationNotPresentedDetentIdentifier {
            isSelectMRTStationPresented = false
        }
    }
}
