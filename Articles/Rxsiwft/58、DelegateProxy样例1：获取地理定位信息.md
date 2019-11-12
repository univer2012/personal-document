委托（`delegate`） iOS 开发中十分常见。不管是使用系统自带的库，还是一些第三方组件时，我们总能看到 `delegate` 的身影。使用 `delegate` 可以实现代码的松耦合，减少代码复杂度。但如果我们项目中使用 `RxSwift`，那么原先的 `delegate` 方式与我们链式编程方式就不相称了。

  解决办法就是将代理方法进行一层 `Rx` 封装，这样做不仅会减少许多不必要的工作（比如原先需要遵守不同的代理，并且要实现相应的代理方法），还会使得代码的聚合度更高，更加符合响应式编程的规范。

  其实在 RxCocoa 源码中我们也可以发现，它已经对标准的 `Cocoa` 做了大量的封装（比如 `tableView` 的 `itemSelected`）。下面我将通过样例演示如何将代理方法进行 `Rx` 化。

## 一、对 Delegate进行Rx封装原理

### 1，DelegateProxy

（1）`DelegateProxy` 是代理委托，我们可以将它看作是代理的代理。

（2）`DelegateProxy` 的作用是做为一个中间代理，他会先把系统的 `delegate` 对象保存一份，然后拦截 `delegate` 的方法。也就是说在每次触发 `delegate` 方法之前，会先调用 `DelegateProxy` 这边对应的方法，我们可以在这里发射序列给多个订阅者。

### 2，流程图

这里以 `UIScrollView` 为例，`Delegate proxy` 便是其代理委托，它遵守 `DelegateProxyType` 与 `UIScrollViewDelegate`，并能响应 `UIScrollViewDelegate` 的代理方法，这里我们可以为代理委托设计它所要响应的方法（即为订阅者发送观察序列）。

```xml
/***
  
 +-------------------------------------------+
 |                                           |
 | UIView subclass (UIScrollView)            |
 |                                           |
 +-----------+-------------------------------+
             |
             | Delegate
             |
             |
 +-----------v-------------------------------+
 |                                           |
 | Delegate proxy : DelegateProxyType        +-----+---->  Observable<T1>
 |                , UIScrollViewDelegate     |     |
 +-----------+-------------------------------+     +---->  Observable<T2>
             |                                     |
             |                                     +---->  Observable<T3>
             |                                     |
             | forwards events                     |
             | to custom delegate                  |
             |                                     v
 +-----------v-------------------------------+
 |                                           |
 | Custom delegate (UIScrollViewDelegate)    |
 |                                           |
 +-------------------------------------------+
 
 **/
```

## 二、获取地理定位信息样例

这个是 `RxSwift` 的一个官方样例，演示的是如何对 `CLLocationManagerDelegate` 进行 `Rx` 封装。

### 1，效果图

（1）第一次运行时会申请定位权限，如果当前`App`可以使用定位信息时，界面上会实时更新显示当前的经纬度。

![img](https://upload-images.jianshu.io/upload_images/3788243-45d29c514bb1f019.png?imageMogr2/auto-orient/strip|imageView2/2/w/320)



![img](https://upload-images.jianshu.io/upload_images/3788243-e6abf7ad590b2f3a.png?imageMogr2/auto-orient/strip|imageView2/2/w/320)

（2）如果当前 `App` 被禁止使用定位信息，界面上会出现一个提示按钮，点击后会自动跳转到系统权限设置页面。

![img](https://upload-images.jianshu.io/upload_images/3788243-e16cbfc420d25f6f.png?imageMogr2/auto-orient/strip|imageView2/2/w/320)



![img](https://upload-images.jianshu.io/upload_images/3788243-4967a6deabfdb0a4.png?imageMogr2/auto-orient/strip|imageView2/2/w/320)

### 2，准备工作

（1）`RxCLLocationManagerDelegateProxy.swift`

首先我们继承 `DelegateProxy` 创建一个关于定位服务的代理委托，同时它还要遵守 `DelegateProxyType` 和 `CLLocationManagerDelegate` 协议。

```swift
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
```



（2）`CLLocationManager+Rx.swift`

接着我们对 `CLLocationManager` 进行`Rx` 扩展，作用是将`CLLocationManager`与前面创建的代理委托关联起来，将定位相关的 `delegate` 方法转为可观察序列。

注意：下面代码中将 `methodInvoked`方法替换成 `sentMessage` 其实也可以，它们的区别可以看另一篇文章：

- [Swift - RxSwift的使用详解61（sendMessage和methodInvoked的区别）](https://www.jianshu.com/p/0d2875c30083)

```

```

