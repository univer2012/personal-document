委托（`delegate`） iOS 开发中十分常见。不管是使用系统自带的库，还是一些第三方组件时，我们总能看到 `delegate` 的身影。使用 `delegate` 可以实现代码的松耦合，减少代码复杂度。但如果我们项目中使用 `RxSwift`，那么原先的 `delegate` 方式与我们链式编程方式就不相称了。

  解决办法就是将代理方法进行一层 `Rx` 封装，这样做不仅会减少许多不必要的工作（比如原先需要遵守不同的代理，并且要实现相应的代理方法），还会使得代码的聚合度更高，更加符合响应式编程的规范。

  其实在 RxCocoa 源码中我们也可以发现，它已经对标准的 `Cocoa` 做了大量的封装（比如 `tableView` 的 `itemSelected`）。下面我将通过样例演示如何将代理方法进行 `Rx` 化。

## 一、对 Delegate进行Rx封装原理

### 1，DelegateProxy

（1）`DelegateProxy` 是代理委托，我们可以将它看作是代理的代理。

（2）`DelegateProxy` 的作用是做为一个中间代理，他会先把系统的 `delegate` 对象保存一份，然后拦截 `delegate` 的方法。也就是说在每次触发 `delegate` 方法之前，会先调用 `DelegateProxy` 这边对应的方法，我们可以在这里发射序列给多个订阅者。

### 2，流程图

这里以 `UIScrollView` 为例，`Delegate proxy` 便是其代理委托，它遵守 `DelegateProxyType` 与 `UIScrollViewDelegate`，并能响应 `UIScrollViewDelegate` 的代理方法，这里我们可以为代理委托设计它所要响应的方法（即为订阅者发送观察序列）。