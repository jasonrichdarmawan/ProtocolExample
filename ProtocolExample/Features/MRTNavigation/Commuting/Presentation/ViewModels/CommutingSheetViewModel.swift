//
//  CommutingSheetViewModel.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 18/08/23.
//

import Foundation

enum CommutingSheetState {
    case DetailSheet
    case ArrivedAtDestinationSheet
}

protocol CommutingSheetViewModel: ObservableObject {
    var state: CommutingSheetState { get set }
    
    func cancel(animated: Bool) -> Bool
}
