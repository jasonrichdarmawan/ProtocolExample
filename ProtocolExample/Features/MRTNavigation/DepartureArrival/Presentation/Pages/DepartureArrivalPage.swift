//
//  DepartureArrivalV2Page.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 25/07/23.
//

import SwiftUI

struct DepartureArrivalPage<PageVM: DepartureArrivalPageViewModel>: ViewControllable {
    @ObservedObject var pageVM: PageVM

    init(
        pageVM: PageVM
    ) {
        self.pageVM = pageVM
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Where to go today?")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color("departureArrival_text_active"))
            
            Spacer()
        }
        .padding(32)
        .background(.blue)
    }
    
    func viewDidAppear(_ viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(true, animated: false)
        
        _ = pageVM.presentSheet()
    }
}

#if DEBUG
struct DepartureArrivalPage_Preview: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DepartureArrivalPage(
                pageVM: DepartureArrivalPageViewModelImpl(
                    controller: DepartureArrivalPageController(
                        coordinator: MRTNavigationCoordinator(
                            navigationController: UINavigationController())
                    )
                )
            )
                .environment(\.locale, .init(identifier: "id-ID"))
        }
    }
}
#endif
