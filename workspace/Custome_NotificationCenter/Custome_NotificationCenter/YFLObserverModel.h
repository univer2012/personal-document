//
//  YFLObserverModel.h
//  Custome_NotificationCenter
//
//  Created by 远平 on 2019/4/25.
//  Copyright © 2019 远平. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YFLObserverModel : NSObject
@property (nonatomic, strong) id observer; //观察者对象
@property (nonatomic, assign) SEL selector; //执行的方法
@property (nonatomic, copy) NSString *notificationName;//通知名字
@property (nonatomic, strong) id object; //携带参数
@property (nonatomic, strong) NSOperationQueue *operationQueue;//队列
@property (nonatomic, copy) OperationBlock block; //回调


@end

NS_ASSUME_NONNULL_END
