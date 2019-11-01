### 创建一个`.a`的静态文件
进行如下操作：

1. `File` --> `New` --> `Project...`

2. 选中`iOS` ，选择`Framework & Library` 中的`Cocoa Touch Static Library`，命名为`EOCLib`

3. 在`EOCLib`中实现如下代码：

`EOCLib.h`:

```objective-c
//
#import <Foundation/Foundation.h>

@interface EOCLib : NSObject
+ (void)eocMethod;
@end
```

`EOCLib.m`:

```objc
#import "EOCLib.h"

@implementation EOCLib

+ (void)eocMethod {
    NSLog(@"eocMethod");
}
    
@end
```

分别选中模拟器和`Generic iOS Device`，点击箭头运行一遍，然后对`Products`--> `libEOCLib.a`右键，选择`Show in Finder`，会发现目录如下：
