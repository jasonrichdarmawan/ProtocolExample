//
//  CommutingPage.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 31/07/23.
//

import SwiftUI

struct CommutingPage<CommutingVM: CommutingPageViewModel>: ViewControllable {
    @ObservedObject private var commutingVM: CommutingVM
    
    init(commutingVM: CommutingVM = CommutingPageViewModelImpl()) {
        self.commutingVM = commutingVM
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    var body: some View {
        VStack {
            Text("CommutingPage")
        }
    }
    
    func viewWillAppear(_ viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
