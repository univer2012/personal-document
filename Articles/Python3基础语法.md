# Python3 基础语法

## 编码

 默认情况下，Python 3 源码文件以 **UTF-8** 编码，所有字符串都是 unicode 字符串。 当然你也可以为源码文件指定不同的编码： 

```
# -*- coding: cp-1252 -*-
```

上述定义允许在源文件中使用 Windows-1252 字符集中的字符编码，对应适合语言为保加利亚语、白罗斯语、马其顿语、俄语、塞尔维亚语。

------

## 标识符

- 第一个字符必须是字母表中字母或下划线 _ 。
- 标识符的其他的部分由字母、数字和下划线组成。
- 标识符对大小写敏感。

 在 Python 3 中，可以用中文作为变量名，非 ASCII 标识符也是允许的了。 

------

## python保留字

 保留字即关键字，我们不能把它们用作任何标识符名称。Python 的标准库提供了一个 keyword 模块，可以输出当前版本的所有关键字： 

```python
import  keyword
print (keyword.kwlist)
```

打印：

```python
['False', 'None', 'True', 'and', 'as', 'assert', 'async', 'await', 'break', 'class', 'continue', 'def', 'del', 'elif', 'else', 'except', 'finally', 'for', 'from', 'global', 'if', 'import', 'in', 'is', 'lambda', 'nonlocal', 'not', 'or', 'pass', 'raise', 'return', 'try', 'while', 'with', 'yield']

```

## 注释

 Python中单行注释以 **#** 开头，实例如下： 

```python

#!/usr/bin/python3
 
# 第一个注释
print ("Hello, Python!") # 第二个注释

```

执行以上代码，输出结果为：

```
Hello, Python!
```

多行注释可以用多个 # 号，还有  ''' 和 """：

```python

#!/usr/bin/python3
 
# 第一个注释
# 第二个注释
 
'''
第三注释
第四注释
'''
 
"""
第五注释
第六注释
"""
print ("Hello, Python!")
```



## 行与缩进 

 python最具特色的就是使用缩进来表示代码块，不需要使用大括号 `{}` 。

**缩进的空格数是可变的，但是同一个代码块的语句必须包含相同的缩进空格数**。实例如下： 

```python
if True:
    print ("True")
else:
    print ("False")
```

以下代码最后一行语句缩进数的空格数不一致，会导致运行有偏差：

```python
if True:
    print ("Answer")
    print ("True")
else:
    print ("Answer")
print ("False")
```

以上程序由于缩进不一致，执行后的打印：

```
Answer
True
False
```

## 多行语句

Python 通常是一行写完一条语句，但如果语句很长，我们可以使用反斜杠(\)来实现多行语句，例如：

```python
item = "one" + \
    "two" + \
    "three"
print (item)
```

打印：

```
onetwothree
```

在 `[]`, `{}`, 或 `()` 中的多行语句，不需要使用反斜杠`\`，例如：

```python
total = ['item_one','item_two','item_three'
         ,'item_four','item_five']
print (total)
```



## 数字(Number)类型

python中数字有四种类型：整数、布尔型、浮点数和复数。

- **int** (整数), 如 1, 只有一种整数类型 int，表示为长整型，没有 python2 中的 Long。
- **bool** (布尔), 如 True。
- **float** (浮点数), 如 1.23、3E-2
- **complex** (复数), 如 1 + 2j、 1.1 + 2.2j

------

## 字符串(String)

- python中单引号和双引号使用完全相同。
- 使用三引号(`'''`或`"""`)可以指定一个多行字符串。
- 转义符 `\`
- 反斜杠可以用来转义，使用`r`可以让反斜杠不发生转义。。 如 `r"this is a line with \n"` 则`\n`会显示，并不是换行。
- 按字面意义级联字符串，如`"this " "is " "string"`会被自动转换为`this is string`。
- 字符串可以用 `+` 运算符连接在一起，用 `*` 运算符重复。
- Python 中的<u>字符串有两种索引方式，从左往右以 0 开始，从右往左以 -1 开始。</u>
- Python中的**字符串不能改变。**
- **Python 没有单独的字符类型，一个字符就是长度为 1 的字符串。**
- 字符串的截取的语法格式如下：`变量[头下标:尾下标:步长]`

```
word = '字符串'
sentence = "这是一个句子"
paragraph = """这是一个段落，
   可以由多行组成"""

print (word)
print (sentence)
print (paragraph)
```

