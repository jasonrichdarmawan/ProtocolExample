//
//  UINavigationController+viewDidLoad.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 28/07/23.
//

import SwiftUI

extension UINavigationController {
    /// allow to .navigationBarBackButtonHidden(true) without losing swipe back gesture.
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
