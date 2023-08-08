//
//  ViewControllable.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 03/08/23.
//

import SwiftUI

protocol ViewControllable: View {
    func viewWillAppear(_ viewController: UIViewController)
    func viewDidAppear(_ viewController: UIViewController)
}

extension ViewControllable {
    func viewWillAppear(_ viewController: UIViewController) {}
    func viewDidAppear(_ viewController: UIViewController) {}
}
