//
//  Alarm.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import SwiftUI

/// will play alarm for 1 second
struct AlarmView<AlarmVM: AlarmViewModel>: ViewControllable {
    @ObservedObject private var alarmVM: AlarmVM
    
    init(
        alarVM: AlarmVM = AlarmViewModelImpl()
    ) {
        self.alarmVM = alarVM
    }
    
    var body: some View {
        Button {
            alarmVM.isMutedMode.toggle()
        } label: {
            Image(alarmVM.isMutedMode ? "SoundOff" : "SoundOn")
        }
    }
}

extension AlarmView {
    func viewWillAppear(_ viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

#if DEBUG
struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView()
    }
}
#endif
