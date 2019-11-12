//
//  RxCLLocationManagerDelegateProxy.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/11/12.
//  Copyright © 2019 远平. All rights reserved.
//

import CoreLocation
import RxSwift
import RxCocoa

extension CLLocationManager: HasDelegate {
    public typealias Delegate = CLLocationManagerDelegate
}

public class RxCLLocationManagerDelegateProxy:
    DelegateProxy<CLLocationManager, CLLocationManagerDelegate>,
    DelegateProxyType,
CLLocationManagerDelegate {
    
    public init(locationManager: CLLocationManager) {
        
        super.init(parentObject: locationManager, delegateProxy: RxCLLocationManagerDelegateProxy.self)
        
    }
    
    public static func registerKnownImplementations() {
        self.register { (parent) -> RxCLLocationManagerDelegateProxy in
            RxCLLocationManagerDelegateProxy(locationManager: parent)
        }
    }
    
    internal lazy var didUpdateLocationsSubject = PublishSubject<[CLLocation]>()
    internal lazy var didFailWithErrorSubject = PublishSubject<Error>()
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        _forwardToDelegate?.locationManager(manager, didUpdateLocations: locations)
        didUpdateLocationsSubject.onNext(locations)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        _forwardToDelegate?.locationManager(manager, didFailWithError: error)
        didFailWithErrorSubject.onNext(error)
    }
    
    deinit {
        self.didUpdateLocationsSubject.on(.completed)
        self.didFailWithErrorSubject.on(.completed)
    }
    
}
