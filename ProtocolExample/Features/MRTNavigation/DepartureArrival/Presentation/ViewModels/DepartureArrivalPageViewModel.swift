//
//  DepartureArrivalPageViewModel.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 10/08/23.
//

import Foundation

protocol DepartureArrivalPageViewModel: ObservableObject {
    func presentSheet() -> Bool
}
