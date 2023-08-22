//
//  CommutingPage.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 31/07/23.
//

import SwiftUI

struct CommutingPage<PageVM: CommutingPageViewModel>: ViewControllable {
    @ObservedObject var pageVM: PageVM
    
    init(pageVM: PageVM) {
        self.pageVM = pageVM
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 16) {
                Spacer()
                AlarmView()
            }
            
            GIFImage(name: "Train")
                .frame(width: 227, height: 153)
                .padding(.top, 32)
                .padding(.horizontal, 80)
            
            Spacer()
        }
        .padding(32)
        .background(.blue)
    }
    
    func viewDidAppear(_ viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(true, animated: false)
        
        _ = pageVM.nextPage()
    }
}

struct CommutingPage_Previews: PreviewProvider {
    static var previews: some View {
        CommutingPage(
            pageVM: CommutingPageViewModelImpl(
                coordinator: MRTNavigationCoordinator(
                    navigationController: UINavigationController()))
        )
        .environment(\.locale, .init(identifier: "id-ID"))
    }
}
