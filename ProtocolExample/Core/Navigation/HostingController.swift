//
//  HostingController.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 03/08/23.
//

import SwiftUI

final class HostingController<ContentView>: UIHostingController<ContentView> where ContentView: ViewControllable {
    private let id: UUID
    
    init(id: UUID = UUID(), rootView: ContentView) {
        self.id = id
        super.init(rootView: rootView)
#if DEBUG
        print("\(type(of: self)) \(#function) \(id.uuidString)")
#endif
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        self.id = UUID()
        super.init(coder: aDecoder)
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    deinit {
#if DEBUG
        print("\(type(of: self)) \(#function) \(id.uuidString)")
#endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rootView.viewWillAppear(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rootView.viewDidAppear(self)
    }
}
