## 1.public和open的区别
答：
来自：[private、fileprivate、internal、public和open的区别](https://www.jianshu.com/p/2e320f27afda)

在Swift语言中，访问修饰符有五种，分别为fileprivate，private，internal，public和open，其中 fileprivate和open是Swift 3新添加的。由于过去 Swift对于访问权限的控制是基于文件的，不是基于类的。这样会有问题，所以Swift 3新增了两个修饰符对原来的private、public进行细分。

### private

 private所修饰的属性或者方法只能在当前类里访问

 private所修饰类只能在当前.swift文件里访问



### fileprivate 

fileprivate访问级别所修饰的属性或者方法在当前的Swift源文件里可以访问。

###  internal（默认访问级别，internal修饰符可写可不写）

internal访问级别所修饰的属性或方法，在源代码所在的整个模块都可以访问、被继承、被重写

如果是框架或者库代码，则在整个框架内部都可以访问，框架由外部代码所引用时，则不可以访问。即使使用import，也会提示错误：

> No such module '...'

如果是App代码，也是在整个App代码，也是在整个App内部可以访问。

### public

可以被任何类访问。<font color=#FF0000>但其他module中不可以被override和继承，而在module内可以被override和继承。</font>

> Cannot inherit from non-open class '...' outside of its defining module

# open

可以被任何类使用，包括override和继承。

访问权限排序从高到低排序：open>public>interal > fileprivate >private

### 总结

属性和方法的访问控制通俗的分级顺序应该是：

> 当前类（private）、当前swift文件（fileprivate）、 当前模块（internal）、其它模块（open、public）
>
> 属性和方法的修饰：在当前模块internal、open、public是同一级别，在外模块open、public是同一级别

类的访问级别:

> 当前类（private）、当前swift文件（fileprivate）、 当前模块（internal）、其它模块(open需要import)、是否可被继承被重写(public需要import)
>
> 可以发现cocopod导入的第三方库，作为外模块一般都是使用的open、public修饰类，来提供给项目使用





## 2.throws和rethrows的用法与作用，try?和try!是什么意思


## 3.Self的使用场景，associatetype的作用

## 4.map、filter、reduce的作用，map与flatmap的区别


## 5.GCD与NSOperationQueue有哪些异同


## 6.图解MVC，MVVM架构


## 7.如何提升tableview的了流畅度


## 8.图解一下TCP发起连接和断开连接的过程。