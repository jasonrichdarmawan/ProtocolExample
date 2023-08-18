//
//  CommutingPageViewModel.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 01/08/23.
//

import Foundation

protocol CommutingPageViewModel: ObservableObject {
    func nextPage() -> Bool
}
