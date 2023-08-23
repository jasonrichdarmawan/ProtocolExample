//
//  BeaconFinderImpl.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import CoreLocation

final class BeaconFinderImpl: NSObject, BeaconFinder {
    weak var delegate: BeaconFinderDelegate?
    
    private var locationManager: CLLocationManager
    private var beaconConstraints: [CLBeaconIdentityConstraint: [CLBeacon]]
    
    fileprivate init(
        locationManager: CLLocationManager = CLLocationManager(),
        beaconConstraints: [CLBeaconIdentityConstraint: [CLBeacon]] = .init()
    ) {
        self.locationManager = locationManager
        self.beaconConstraints = beaconConstraints
        
        self.locationManager.allowsBackgroundLocationUpdates = true
        
        // when the app moves to the background,
        // the system will change the status bar appearance to indicate that location services are in use
        self.locationManager.showsBackgroundLocationIndicator = true
        
        super.init()
        
        self.locationManager.delegate = self
        
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    deinit {
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    func isAuthorizedOrRequestAuthorization() -> Bool {
        return false
    }
    
    func start(constraint: CLBeaconIdentityConstraint) -> BeaconFinderStartEvent {
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
        
        if locationManager.authorizationStatus == .denied {
            return .NOT_AUTHORIZED
        }
        
        if locationManager.authorizationStatus != .authorizedAlways {
            return .NOT_AUTHORIZED
        }
        
        locationManager.startUpdatingLocation()
        
        beaconConstraints[constraint] = .init()
        
        let beaconRegion = CLBeaconRegion(beaconIdentityConstraint: constraint, identifier: constraint.uuid.uuidString)
        /// It will invoke func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion),
        /// if the finder found a beacon with exact beacon identity constraint
        ///
        /// By monitoring for the beacon before ranging, the app is more energy efficient if the beacon is not immediately observable.
        locationManager.startMonitoring(for: beaconRegion)
        
        return .IS_STARTING
    }
    
    func stop() -> BeaconFinderStopEvent {
        for region in locationManager.monitoredRegions {
            locationManager.stopMonitoring(for: region)
        }
        
        for constraint in beaconConstraints.keys {
            locationManager.stopRangingBeacons(satisfying: constraint)
        }
        
        locationManager.stopUpdatingLocation()
        
        return .IS_STOPPING
    }
}

extension BeaconFinderImpl: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        let beaconRegion = region as? CLBeaconRegion
        
        /// .inside: found a beacon with the exact beacon identity constraint (can be any combination of uuid, major, minor)
        if state == .inside {
            manager.startRangingBeacons(satisfying: beaconRegion!.beaconIdentityConstraint)
        } else {
            manager.stopRangingBeacons(satisfying: beaconRegion!.beaconIdentityConstraint)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        beaconConstraints[beaconConstraint] = beacons
        
        delegate?.notifyManager(self, didRange: beaconConstraints)
    }
}

extension BeaconFinderImpl {
    static weak var shared: BeaconFinder! {
        get {
            var temp: BeaconFinder
            
            if sharedClosure == nil {
                temp = BeaconFinderImpl()
                sharedClosure = temp
            }
            
            return sharedClosure
        }
    }
    
    private static weak var sharedClosure: BeaconFinder?
}
