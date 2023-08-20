//
//  CommutingSheetViewModel.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 18/08/23.
//

import Foundation

protocol CommutingSheetViewModel: ObservableObject {
    var hideDetail: Bool { get set }
}
