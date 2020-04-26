[iOS 十种线程锁](https://www.jianshu.com/p/7e9dd2cb78a8)

# 一、锁 是什么意思？

- 我们在使用多线程的时候多个线程可能会访问同一块资源，这样就很容易引发数据错乱和数据安全等问题，这时候就需要我们保证每次只有一个线程访问这一块资源，锁 应运而生。
- 这里顺便提一下,上锁的两种方式trylock和lock使用场景：

> 当前线程锁失败，也可以继续其它任务，用 trylock 合适
>
> 当前线程只有锁成功后，才会做一些有意义的工作，那就 lock，没必要轮询 trylock
>
> 注:以下大部分锁都会提供trylock接口,不再作解释


![](https://upload-images.jianshu.io/upload_images/1646251-a2b121ff413d9c7c.png?imageMogr2/auto-orient/strip|imageView2/2/w/1060)


## 一、OSSpinLock (自旋锁)

测试中效率最高的锁, 不过经YYKit作者确认, OSSpinLock已经不再线程安全,OSSpinLock有潜在的优先级反转问题.不再安全的 OSSpinLock;
```
需要导入头文件
#import <libkern/OSAtomic.h>
// 初始化
 OSSpinLock spinLock = OS_SPINLOCK_INIT;
// 加锁
OSSpinLockLock(&spinLock);
// 解锁
OSSpinLockUnlock(&spinLock);
// 尝试加锁，可以加锁则立即加锁并返回 YES,反之返回 NO
OSSpinLockTry(&spinLock);
/*
注:苹果爸爸已经在iOS10.0以后废弃了这种锁机制,使用os_unfair_lock 替换,
顾名思义能够保证不同优先级的线程申请锁的时候不会发生优先级反转问题.
*/
```

## 二、os_unfair_lock(互斥锁)
```
需要导入头文件
#import <os/lock.h>
// 初始化
 os_unfair_lock unfair_lock = OS_UNFAIR_LOCK_INIT;
// 加锁
os_unfair_lock_lock(&unfair_lock);
// 解锁
os_unfair_lock_unlock(&unfair_lock);
// 尝试加锁，可以加锁则立即加锁并返回 YES,反之返回 NO
os_unfair_lock_trylock(&unfair_lock);
/*
注:解决不同优先级的线程申请锁的时候不会发生优先级反转问题.
不过相对于 OSSpinLock , os_unfair_lock性能方面减弱了许多.
*/
```

## 三、dispatch_semaphore (信号量)
```
// 初始化
dispatch_semaphore_t semaphore_t = dispatch_semaphore_create(1);
// 加锁
dispatch_semaphore_wait(semaphore_t,DISPATCH_TIME_FOREVER);
// 解锁
dispatch_semaphore_signal(semaphore_t);
/*
注: dispatch_semaphore  其他两个功能
1.还可以起到阻塞线程的作用.
2.可以实现定时器功能,这里不做过多介绍.
*/
```

## 四、pthread_mutex(互斥锁)
```
//需要导入头文件
#import <pthread/pthread.h>
// 初始化(两种)
1.普通初始化
pthread_mutex_t mutex_t;
pthread_mutex_init(&mutex_t, NULL); 
2.宏初始化
pthread_mutex_t mutex =PTHREAD_MUTEX_INITIALIZER;
// 加锁
pthread_mutex_lock(&mutex_t);
// 解锁
pthread_mutex_unlock(&mutex_t);
// 尝试加锁，可以加锁时返回的是 0，否则返回一个错误
pthread_mutex_trylock(& mutex_t)
```

## 五、NSLock(互斥锁、对象锁)
```
// 初始化
NSLock *_lock = [[NSLock alloc]init];
// 加锁
[_lock lock];
// 解锁
[_lock unlock];
// 尝试加锁，可以加锁则立即加锁并返回 YES,反之返回 NO
[_lock tryLock];
```

## 六、NSCondition(条件锁、对象锁)
```
// 初始化
NSCondition *_condition= [[NSCondition alloc]init];
// 加锁
[_condition lock];
// 解锁
[_condition unlock];
/*
其他功能接口
wait 进入等待状态
waitUntilDate:让一个线程等待一定的时间
signal 唤醒一个等待的线程
broadcast 唤醒所有等待的线程
注: 所测时间波动太大, 有时候会快于 NSLock, 我取得中间值.
*/
```

## 七、NSConditionLock(条件锁、对象锁)
```
// 初始化
NSConditionLock *_conditionLock = [[NSConditionLock alloc]init];
// 加锁
[_conditionLock lock];
// 解锁
[_conditionLock unlock];
// 尝试加锁，可以加锁则立即加锁并返回 YES,反之返回 NO
[_conditionLock tryLock];
/*
其他功能接口
- (instancetype)initWithCondition:(NSInteger)condition NS_DESIGNATED_INITIALIZER; //初始化传入条件
- (void)lockWhenCondition:(NSInteger)condition;//条件成立触发锁
- (BOOL)tryLockWhenCondition:(NSInteger)condition;//尝试条件成立触发锁
- (void)unlockWithCondition:(NSInteger)condition;//条件成立解锁
- (BOOL)lockBeforeDate:(NSDate *)limit;//触发锁 在等待时间之内
- (BOOL)lockWhenCondition:(NSInteger)condition beforeDate:(NSDate *)limit;//触发锁 条件成立 并且在等待时间之内
*/
```

## 八、NSRecursiveLock(递归锁、对象锁)
```
// 初始化
NSRecursiveLock *_recursiveLock = [[NSRecursiveLock alloc]init];
// 加锁
[_recursiveLock lock];
// 解锁
[_recursiveLock unlock];
// 尝试加锁，可以加锁则立即加锁并返回 YES,反之返回 NO
[_recursiveLock tryLock];
/*
注: 递归锁可以被同一线程多次请求，而不会引起死锁。
即在同一线程中在未解锁之前还可以上锁, 执行锁中的代码。
这主要是用在循环或递归操作中。
- (BOOL)lockBeforeDate:(NSDate *)limit;//触发锁 在等待时间之内
*/
```

## 九、@synchronized()递归锁
```
// 初始化
@synchronized(锁对象){
}
底层封装的pthread_mutex的PTHREAD_MUTEX_RECURSIVE 模式,
锁对象来表示是否为同一把锁
```
## 十、pthread_mutex(recursive)(递归锁)
```
// 初始化
pthread_mutex_t mutex_t;
pthread_mutexattr_t attr;
pthread_mutexattr_init(&attr); //初始化attr并且给它赋予默认pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE); //设置锁类型，这边是设置为递归锁
pthread_mutex_init(&mutex_t, &attr);
pthread_mutexattr_destroy(&attr); //销毁一个属性对象，在重新进行初始化之前该结构不能重新使用
// 加锁
pthread_mutex_lock(&mutex_t);
// 解锁
pthread_mutex_unlock(&mutex_t);
/*
注: 递归锁可以被同一线程多次请求，而不会引起死锁。
即在同一线程中在未解锁之前还可以上锁, 执行锁中的代码。
这主要是用在循环或递归操作中。
*/
```

# 性能总结

```
OSSpinLock                          0.097348s
dispatch_semaphore                  0.155043s
os_unfair_lock                      0.171789s
pthread_mutex                       0.262592s
NSLock                              0.283196s
pthread_mutex(recursive)            0.372398s
NSRecursiveLock                     0.473536s
NSConditionLock                     0.950285s
@synchronized                       1.101924s
注:建议正常锁功能用 pthread_mutex ,os_unfair_lock (适配低版本)
```

