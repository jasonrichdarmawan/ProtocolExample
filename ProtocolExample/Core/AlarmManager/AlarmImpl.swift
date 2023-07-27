//
//  AlarmManagerImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import AVFoundation
import UIKit

final class AlarmImpl: Alarm {
    static let mutedModeSystemSoundID = SystemSoundID(1519)
    static let unMutedModeSystemSoundID = SystemSoundID(1005)
    
    private var backgroundTaskID: UIBackgroundTaskIdentifier?
    
    fileprivate init() {}
    
    func playVibrationOnly() -> Bool {
        if AlarmManager.isPlaying { return false }
        
        _ = beginBackgroundTask()
        
        AudioServicesPlayAlertSound(AlarmImpl.mutedModeSystemSoundID)
        AudioServicesAddSystemSoundCompletion(
            AlarmImpl.mutedModeSystemSoundID, nil, nil,
            { _, _ in AudioServicesPlayAlertSound(AlarmImpl.mutedModeSystemSoundID) },
            nil
        )
        
        return true
    }
    
    func playVibrationAndAudio() -> Bool {
        if AlarmManager.isPlaying { return false }
        
        _ = beginBackgroundTask()
        
        AudioServicesPlayAlertSound(AlarmImpl.unMutedModeSystemSoundID)
        AudioServicesAddSystemSoundCompletion(
            AlarmImpl.unMutedModeSystemSoundID, nil, nil,
            { _, _ in AudioServicesPlayAlertSound(AlarmImpl.unMutedModeSystemSoundID) },
            nil
        )
        
        return true
    }
    
    func stop() -> Bool {
        AudioServicesRemoveSystemSoundCompletion(AlarmImpl.mutedModeSystemSoundID)
        AudioServicesRemoveSystemSoundCompletion(AlarmImpl.unMutedModeSystemSoundID)
        
        return true
    }
}

extension AlarmImpl {
    private func beginBackgroundTask() -> Bool {
        switch UIApplication.shared.applicationState {
        case .background, .inactive:
#if DEBUG
            print("\(type(of: self)) \(#function) starting background task.")
#endif
            backgroundTaskID = UIApplication.shared.beginBackgroundTask(
                withName: "Play alert in background mode",
                expirationHandler: {
                    guard let backgroundTaskID = self.backgroundTaskID else { return }
                    
#if DEBUG
                    print("\(type(of: self)) \(#function) stopping background task by system.")
#endif
                    
                    UIApplication.shared.endBackgroundTask(backgroundTaskID)
                }
            )
            
            return true
        default: return false
        }
    }
    
    private func endBackgroundTask() -> Bool {
        guard let backgroundTaskID else { return false }
        
#if DEBUG
        print("\(type(of: self)) \(#function) stopping background task manually.")
#endif
        
        UIApplication.shared.endBackgroundTask(backgroundTaskID)
        
        return true
    }
}

extension AlarmImpl {
    static var shared: AlarmImpl! {
        get {
            if sharedClosure == nil {
                sharedClosure = AlarmImpl()
            }
            
            return sharedClosure
        }
        set {
            sharedClosure = newValue
        }
    }
    
    private static var sharedClosure: AlarmImpl!
}
