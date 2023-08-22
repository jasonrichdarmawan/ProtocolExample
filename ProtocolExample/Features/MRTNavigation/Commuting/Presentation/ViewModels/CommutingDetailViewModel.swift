//
//  CommutingDetailViewModel.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 22/08/23.
//

import Foundation

protocol CommutingDetailViewModel: ObservableObject {
    var hideDetail: Bool { get set }
    
    func setAsDelegate() -> Bool
}
