//
//  Controller.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 25/08/23.
//

import UIKit

protocol Controller: AnyObject {
    var coordinator: Coordinator? { get }
    var viewController: UIViewController? { get }
    
    func loadView() -> Bool
}
