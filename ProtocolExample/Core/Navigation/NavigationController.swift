//
//  NavigationController.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

final class NavigationController: UINavigationController {
    private let id: UUID
    
    var willPopHandler: (() -> Void)?
    
    init(id: UUID = UUID()) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
#if DEBUG
        print("\(type(of: self)) \(#function) \(id.uuidString)")
#endif
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = UUID()
        super.init(coder: aDecoder)
    }
    
    deinit {
#if DEBUG
        print("\(type(of: self)) \(#function) \(id.uuidString)")
#endif
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        willPopHandler?()
        willPopHandler = nil
        return super.popViewController(animated: true)
    }
}
