## 11.Python 判断奇数偶数

以下实例用于判断一个数字是否为奇数或偶数：

```python
num = int(input('输入一个数字: '))
if (num % 2) == 0:
    print('{0} 是偶数'.format(num))
else:
    print('{0} 是奇数'.format(num))
```

我们也可以使用内嵌 if 语句来实现：

执行以上代码输出结果为：

```
输入一个数字: 3
3 是奇数
```



## 12.Python 判断闰年

以下实例用于判断用户输入的年份是否为闰年： 

```python
year = int(input('输入一个年份: '))
if (year % 4) == 0:
    if (year % 100) == 0:
        if (year % 400) == 0:               # 整百年能被400整除的是闰年
            print('{0} 是闰年'.format(year))
        else:
            print('{0} 不是闰年'.format(year))
    else:
        print('{0} 是闰年'.format(year))       # 非整百年能被4整除的为闰年
else:
    print('{0} 不是闰年'.format(year))

```

我们也可以使用内嵌 if 语句来实现：

执行以上代码输出结果为：

```
输入一个年份: 2000
2000 是闰年
```

```
输入一个年份: 2011
2011 不是闰年
```



## 13.Python 获取最大值函数

以下实例中我们使用`max()`方法求最大值：

```python
# 最简单的
print(max(1, 2))
print(max('a', 'b'))

# 也可以对列表和元组使用
print(max([1,2]))
print(max((1,2)))

# 更多实例
print("80, 100, 1000 最大值为: ", max(80, 100, 1000))
print("-20, 100, 400 最大值为: ", max(-20, 100, 400))
print("-80, -20, -10 最大值为: ", max(-80, -20, -10))
print("0, 100, -400 最大值为: ", max(0, 100, -400))
```

执行以上代码输出结果为：

```
2
b
2
2
80, 100, 1000 最大值为:  1000
-20, 100, 400 最大值为:  400
-80, -20, -10 最大值为:  -10
0, 100, -400 最大值为:  100
```

max() 函数介绍：[Python max()](https://www.runoob.com/python/func-number-max.html)函数。



## 14.Python 质数判断

一个大于1的自然数，除了1和它本身外，不能被其他自然数（质数）整除（2, 3, 5, 7等），换句话说就是该数除了1和它本身以外不再有其他的因数。

```python
# Python 程序用于检测用户输入的数字是否为质数
# 用户输入数字
num = int(input('请输入一个数字: '))

# 质数大于 1
if num > 1:
    # 查看因子
    for i in range(2, num):
        if (num % i) == 0:
            print(num, '不是质数')
            print(i , '乘于', num // i, '是', num)
            break
    else:
        print(num, '是质数')

# 如果输入的数字小于或等于1， 不是质数
else:
    print(num, '不是质数')
```

执行以上代码输出结果为：

```
(venv) yuanpingdeAir:venv yuanping$ python3 hello_world.py 
请输入一个数字: 1
1 不是质数
(venv) yuanpingdeAir:venv yuanping$ python3 hello_world.py 
请输入一个数字: 4
4 不是质数
2 乘于 2 是 4
(venv) yuanpingdeAir:venv yuanping$ python3 hello_world.py 
请输入一个数字: 5
5 是质数
(venv) yuanpingdeAir:venv yuanping$ 
```

