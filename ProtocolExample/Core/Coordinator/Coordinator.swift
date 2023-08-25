//
//  Coordinator.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    
    func showRoute(_ route: NavigationRoute) -> Bool
    func canPopToRoute(_ route: NavigationRoute) -> Bool
    func popToRoute(_ route: NavigationRoute) -> Bool
    func popToRootViewController(_ route: NavigationRoute) -> Bool
    
    func popViewController(animated: Bool) -> Bool
    func dismiss(animated: Bool) -> Bool
}

extension Coordinator {
    func showRoute(_ route: NavigationRoute) -> Bool { return false }
    func canPopToRoute(_ route: NavigationRoute) -> Bool { return false }
    func popToRoute(_ route: NavigationRoute) -> Bool { return false }
    
    func popToRootViewController(_ route: NavigationRoute) -> Bool { return false }
    
    func popViewController(animated: Bool) -> Bool {
        navigationController.popViewController(animated: animated)
        return true
    }
    
    func dismiss(animated: Bool) -> Bool {
        navigationController.dismiss(animated: animated)
        return true
    }
}
