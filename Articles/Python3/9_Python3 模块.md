来自：[Python3 模块](https://www.runoob.com/python3/python3-module.html)



在前面的几个章节中我们脚本上是用 python 解释器来编程，如果你从 Python 解释器退出再进入，那么你定义的所有的方法和变量就都消失了。

**为此 Python 提供了一个办法，把这些定义存放在文件中，为一些脚本或者交互式的解释器实例使用，这个文件被称为<u>模块</u>**。

模块是一个包含所有你定义的函数和变量的文件，其后缀名是`.py`。模块可以被别的程序引入，以使用该模块中的函数等功能。这也是使用 python 标准库的方法。

下面是一个使用 python 标准库中模块的例子。 

```python
#!/usr/bin/python3
# 文件名: using_sys.py

import  sys
print('命令行参数如下:')
for i in sys.argv:
    print(i)

print('\n\nPython 路径为：',sys.path, '\n')
```

执行结果如下所示：

```python
$ cd venv
(PycharmProjects) bogon:venv mac$ ls
bin             hello_world.py  high_low.py     lib             pyvenv.cfg
(PycharmProjects) bogon:venv mac$ python hello_world.py 
命令行参数如下:
hello_world.py


Python 路径为： ['/Users/mac/Desktop/Personal Documents/personal-document/workspace/PycharmProjects/Demo1/venv', '/Library/Frorks/Python.framework/Versions/3.8/lib/python38.zip', '/Library/Frameworks/Python.framework/Versions/3.8/lib/python3.8', '/Library/Frameworks/Python.framework/Versions/3.8/lib/python3.8/lib-dynload', '/Users/mac/Documents/PycharmProjects/lib/python3.8/site-packages', '/Library/Frameworks/Python.framework/Versions/3.8/lib/python3.8/site-packages'] 

(PycharmProjects) bogon:venv mac$ 
```

- 1、`import sys` 引入 python 标准库中的 `sys.py` 模块；这是引入某一模块的方法。
-  2、`sys.argv` 是一个包含命令行参数的列表。
-  3、`sys.path` 包含了一个 Python 解释器自动查找所需模块的路径的列表。 

------



## import 语句

想使用 Python 源文件，只需在另一个源文件里执行 import 语句，语法如下：

```python
import module1[, module2[,... moduleN]
```

 当解释器遇到 `import` 语句，如果模块在当前的搜索路径就会被导入。 

搜索路径是一个解释器会先进行搜索的所有目录的列表。如想要导入模块 support，需要把命令放在脚本的顶端：

```python
###【support.py 文件代码】
#!/usr/bin/python3
# Filename: support.py

def print_func(par):
    print('Hello : ',par)
    return
```

`test.py` 引入 `support` 模块：

```python
#!/usr/bin/python3
# Filename: test.py

# 导入模块
import  support

support.print_func('univer2012')
```

以上实例输出结果：

```
(PycharmProjects) bogon:venv mac$ python3 test.py
Hello :  univer2012
(PycharmProjects) bogon:venv mac$
```



**一个模块只会被导入一次，不管你执行了多少次`import`。这样可以防止导入模块被一遍又一遍地执行。**

当我们使用`import`语句的时候，Python解释器是怎样找到对应的文件的呢？

这就涉及到Python的搜索路径，搜索路径是由一系列目录名组成的，Python解释器就依次从这些目录中去寻找所引入的模块。 

 这看起来很像环境变量，事实上，也可以通过定义环境变量的方式来确定搜索路径。

搜索路径是在Python编译或安装的时候确定的，安装新的库应该也会修改。搜索路径被存储在sys模块中的path变量，做一个简单的实验，在交互式解释器中，输入以下代码： 

```python
>>> import sys
>>> sys.path
['', '/Users/mac/Documents', '/Library/Frameworks/Python.framework/Versions/3.8/lib/python38.zip', '/Library/Frameworks/Python.framework/Versions/3.8/lib/python3.8', '/Library/Frameworks/Python.framework/Versions/3.8/lib/python3.8/lib-dynload', '/Library/Frameworks/Python.framework/Versions/3.8/lib/python3.8/site-packages']
>>> 
```



`sys.path` 输出是一个列表，其中第一项是空串''，代表当前目录（若是从一个脚本中打印出来的话，可以更清楚地看出是哪个目录），亦即我们执行python解释器的目录（对于脚本的话就是运行的脚本所在的目录）。 

 因此若像我一样在当前目录下存在与要引入模块同名的文件，就会把要引入的模块屏蔽掉。 

 了解了搜索路径的概念，就可以在脚本中修改`sys.path`来引入一些不在搜索路径中的模块。 

 

现在，在解释器的当前目录或者 `sys.path` 中的一个目录里面来创建一个`fibo.py`的文件，代码如下：

```python
#!/usr/bin/python3

import  fibo

fibo.fib(1000)

print(fibo.fib2(100))

print(fibo.__name__)
```

打印：

```
1  1  2  3  5  8  13  21  34  55  89  144  233  377  610  987  
[1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
fibo
```



如果你打算经常使用一个函数，你可以把它赋给一个本地的名称：

```python
import  fibo

fib = fibo.fib
fib(500)
#打印: 1  1  2  3  5  8  13  21  34  55  89  144  233  377  
```



##  from … import 语句

Python 的 from 语句让你从模块中导入一个指定的部分到当前命名空间中，语法如下：

```python
from modname import name1[, name2[, ... nameN]]
```

例如，要导入模块 fibo 的 fib 函数，使用如下语句：

```python
#!/usr/bin/python3

from fibo import fib, fib2

fib(500)
```

打印：

```
1  1  2  3  5  8  13  21  34  55  89  144  233  377  
```



这个声明不会把整个fibo模块导入到当前的命名空间中，它只会将fibo里的fib函数引入进来。



------

## from … import * 语句

 把一个模块的所有内容全都导入到当前的命名空间也是可行的，只需使用如下声明： 

```python
from modname import *
```

这提供了一个简单的方法来导入一个模块中的所有项目。然而这种声明不该被过多地使用。 

------

## 深入模块

模块除了方法定义，还可以包括可执行的代码。这些代码一般用来初始化这个模块。这些代码只有在第一次被导入时才会被执行。

每个模块有各自独立的符号表，在模块内部为所有的函数当作全局符号表来使用。 

所以，模块的作者可以放心大胆的在模块内部使用这些全局变量，而不用担心把其他用户的全局变量搞混。 

从另一个方面，当你确实知道你在做什么的话，你也可以通过 modname.itemname 这样的表示法来访问模块内的函数。  

模块是可以导入其他模块的。在一个模块（或者脚本，或者其他地方）的最前面使用 import 来导入一个模块，当然这只是一个惯例，而不是强制的。被导入的模块的名称将被放入当前操作的模块的符号表中。 

还有一种导入的方法，可以使用 import 直接把模块内（函数，变量的）名称导入到当前操作模块。比如:

```python
from fibo import fib, fib2

fib(500)
# 打印：1  1  2  3  5  8  13  21  34  55  89  144  233  377  
```

这种导入的方法不会把被导入的模块的名称放在当前的字符表中（所以在这个例子里面，fibo 这个名称是没有定义的）。  

这还有一种方法，可以一次性的把模块中的所有（函数，变量）名称都导入到当前模块的字符表:  

```
from fibo import *

fib(500)
# 打印：1  1  2  3  5  8  13  21  34  55  89  144  233  377  
```

这将把所有的名字都导入进来，但是那些由单一下划线（`_`）开头的名字不在此例。大多数情况， Python程序员不使用这种方法，因为引入的其它来源的命名，很可能覆盖了已有的定义。 