#### 本工程日志

===== 16-11-28

1、研究了加了导航栏时，子控制器隐藏和显示导航栏，系统的滑动返回的情况。发现要用系统的滑动返回，就要在根`navigationController`中加入
`self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
`
子控制器不需要显示导航栏时，需要在`viewWillAppear:`方法中设置`[self.navigationController setNavigationBarHidden:YES animated:animated];`；
同时对于要显示导航栏的父控制器，则需要在`viewWillAppear:`中设置`[self.navigationController setNavigationBarHidden:NO animated:animated];`。

当子控制器的`viewWillAppear:`方法

```[self.navigationController setNavigationBarHidden:animated animated:YES];```
隐藏导航栏时，是没法滑动返回的。

=====来源：[一个丝滑的全屏滑动返回手势](http://blog.sunnyxx.com/2015/06/07/fullscreen-pop-gesture/)
使用第三方组件[FDFullscreenPopGesture](https://github.com/forkingdog/FDFullscreenPopGesture) 可以使子控制器不需要导航栏时，也可以滑动返回，同时保证下一个子控制器还可以显示导航栏。
用法如下：

``` 
- (void)viewDidLoad
[super viewDidLoad];
self.navigationController.fd_prefersNavigationBarHidden = YES;
}
```
或者喜欢重载的写法也行

```
- (BOOL)fd_prefersNavigationBarHidden {
return YES;
}
```

2、研究截获导航栏的返回事件
来源：[截获导航控制器系统返回按钮的点击pop及右滑pop事件](http://www.jianshu.com/p/6376149a2c4c)


