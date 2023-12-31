//
//  LocationExamplePage.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 22/08/23.
//

import SwiftUI

struct LocationExamplePage<LocationVM: LocationExampleViewModel>: ViewControllable {
    @ObservedObject var locationVM: LocationVM
    
    init(locationVM: LocationVM) {
        self.locationVM = locationVM
    }
    
    var body: some View {
        VStack {
            Text("\(locationVM.station?.name ?? "") Station")
        }
    }
}

extension LocationExamplePage {
    func viewWillAppear(_ viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(false, animated: true)
        _ = locationVM.start()
    }
}
