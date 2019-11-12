//
//  CLLocationManager+Rx.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/11/12.
//  Copyright © 2019 远平. All rights reserved.
//

import CoreLocation
import RxSwift
import RxCocoa

extension Reactive where Base: CLLocationManager {
    
    /**
     Reactive wrapper for `delegate`.
     
     For more information take a look at `DelegateProxyType` protocol documentation.
     */
    public var delegate: DelegateProxy<CLLocationManager, CLLocationManagerDelegate> {
        
        return RxCLLocationManagerDelegateProxy.proxy(for: base)
    }
    
    // MARK: Responding to Location Events
    
    /**
     Reactive wrapper for `delegate` message.
     */
    public var didUpdateLocations: Observable<[CLLocation]> {
        
        return RxCLLocationManagerDelegateProxy.proxy(for: base)
            .didUpdateLocationsSubject.asObserver()
    }
    
    /**
     Reactive wrapper for `delegate` message.
     */
    public var didFailWithError: Observable<Error> {
        return RxCLLocationManagerDelegateProxy.proxy(for: base)
            .didFailWithErrorSubject.asObserver()
    }
//    #if ox(iOS) || os(macOS)
    
    public var didFinishDeferredUpdatesWithError: Observable<Error?> {
        return delegate.methodInvoked(#selector(CLLocationManagerDelegate
            .locationManager(_:didFinishDeferredUpdatesWithError:)))
            .map{ a in
                return try castOptionalOrThrow(Error.self, a[1])
        }
    }
    
//    #endif
    
    #if os(iOS)
    public var didPauseLocationUpdates: Observable<Void> {
        return delegate.methodInvoked(#selector(CLLocationManagerDelegate
            .locationManagerDidPauseLocationUpdates(_:)))
            .map{ _ in
                return ()
        }
    }
    
    
    #endif
    
}
