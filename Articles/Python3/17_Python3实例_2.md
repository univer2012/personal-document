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



## 15.Python 输出指定范围内的素数 

素数（prime number）又称质数，有无限个。除了1和它本身以外不再被其他的除数整除。

以下实例可以输出指定范围内的素数：

```python
# 输出指定范围内的素数
lower = int(input('输入区间最小值: '))
upper = int(input('输入区间最大值: '))

for num in range(lower, upper + 1):
    # 素数大于 1
    if num > 1:
        for i in range(2, num):
            if (num % i) == 0:
                break
        else:
            print(num)
```

执行以上程序，输出结果为：

```python
(venv) yuanpingdeAir:venv yuanping$ python3 hello_world.py 
输入区间最小值: 1
输入区间最大值: 100
2
3
5
7
11
13
17
19
23
29
31
37
41
43
47
53
59
61
67
71
73
79
83
89
97
(venv) yuanpingdeAir:venv yuanping$ 
```



## 16.Python 阶乘实例

整数的阶乘（英语：factorial）是所有小于及等于该数的正整数的积，0的阶乘为1。即：n!=1×2×3×...×n。 

```python
# 通过用户输入数字计算阶乘
# 获取用户输入的数字
num = int(input('请输入一个数字: '))
factorial = 1

# 查看数字是负数， 0 或 正数
if num < 0:
    print('抱歉，负数没有阶乘')
elif num == 0:
    print('0 的阶乘为 1')
else:
    for i in range(1, num + 1):
        factorial = factorial * i
    print('%d 的阶乘为 %d' %(num, factorial))
```

执行以上代码输出结果为：

```
请输入一个数字: 5
5 的阶乘为 120
```



## 17.Python 九九乘法表

以下实例演示了如何实现九九乘法表： 

```python
# 九九乘法表
for i in range(1, 10):
    for j in range(1, i+1):
        print('{}x{}={}\t'.format(j,i, i*j), end='')
    print()
```

执行以上代码输出结果为：

```
1x1=1	
1x2=2	2x2=4	
1x3=3	2x3=6	3x3=9	
1x4=4	2x4=8	3x4=12	4x4=16	
1x5=5	2x5=10	3x5=15	4x5=20	5x5=25	
1x6=6	2x6=12	3x6=18	4x6=24	5x6=30	6x6=36	
1x7=7	2x7=14	3x7=21	4x7=28	5x7=35	6x7=42	7x7=49	
1x8=8	2x8=16	3x8=24	4x8=32	5x8=40	6x8=48	7x8=56	8x8=64	
1x9=9	2x9=18	3x9=27	4x9=36	5x9=45	6x9=54	7x9=63	8x9=72	9x9=81	
```

通过指定end参数的值，可以取消在末尾输出回车符，实现不换行。



## 18.Python 斐波那契数列

 斐波那契数列指的是这样一个数列 0, 1, 1, 2, 3, 5, 8, 13,特别指出：第0项是0，第1项是第一个1。从第三项开始，每一项都等于前两项之和。 

Python 实现斐波那契数列代码如下：

```python
# Python 斐波那契数列实现
# 获取用户输入数据
nterms = int(input('你需要几项？'))

# 第一和第一项
n1 = 0
n2 = 1
count = 2
# 判断输入的值是否合法
if nterms <= 0:
    print('请输入一个正整数')
elif nterms == 1:
    print('斐波那契数列：')
    print(n1)
else:
    print('斐波那契数列：')
    print(n1, ',', n2, end= ' , ')
    while count < nterms:
        nth = n1 + n2
        print(nth, end= ' , ')
        # 更新值
        n1 = n2
        n2 = nth
        count += 1
```

执行以上代码输出结果为：

```
你需要几项？ 10
斐波那契数列：
0 , 1 , 1 , 2 , 3 , 5 , 8 , 13 , 21 , 34 ,
```



## 19.Python 阿姆斯特朗数

如果一个n位正整数等于其各位数字的n次方之和,则称该数为阿姆斯特朗数。 例如1^3 + 5^3 + 3^3 = 153。

1000以内的阿姆斯特朗数： 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407。

以下代码用于检测用户输入的数字是否为阿姆斯特朗数：

```python
# Python 检测用户输入的数字是否为阿姆斯特朗数
# 获取用户输入的数字
num = int(input('请输入一个数字: '))
# 初始化变量 sum
sum = 0
# 指数
n = len(str(num))

# 检测
temp = num
while temp > 0:
    digit = temp % 10
    sum += digit ** n
    temp //= 10

# 输出结果
if num == sum:
    print(num, '是阿姆斯特朗数')
else:
    print(num, '不是阿姆斯特朗数')
```

执行以上代码输出结果为：

```python
(venv) yuanpingdeAir:venv yuanping$ python3 hello_world.py 
请输入一个数字: 345
345 不是阿姆斯特朗数
(venv) yuanpingdeAir:venv yuanping$ python3 hello_world.py 
请输入一个数字: 153
153 是阿姆斯特朗数
(venv) yuanpingdeAir:venv yuanping$ python3 hello_world.py 
请输入一个数字: 1634
1634 是阿姆斯特朗数
(venv) yuanpingdeAir:venv yuanping$ 
```



### 获取指定期间内的阿姆斯特朗数

```python
# 获取用户输入数字
lower = int(input('最小值: '))
upper = int(input('最大值: '))

for num in range(lower, upper + 1):
    # 初始化 sum
    sum = 0
    # 指数
    n = len(str(num))

    # 检测
    temp = num
    while temp > 0:
        digit = temp % 10
        sum += digit ** n
        temp //= 10

    if num == sum:
        print(num)
```

执行以上代码输出结果为：

```
最小值: 1
最大值: 10000
1
2
3
4
5
6
7
8
9
153
370
371
407
1634
8208
9474
```

以上实例中我们输出了 1 到 10000 之间的阿姆斯特朗数。



## 20.Python 十进制转二进制、八进制、十六进制

以下代码用于实现十进制转二进制、八进制、十六进制：

```python
# 获取用户输入十进制数
dec = int(input('输入数字: '))

print('十进制数为: ', dec)
print('转换为二进制为: ',bin(dec))
print('转换为八进制为: ',oct(dec))
print('转换为十六进制为: ',hex(dec))
```

执行以上代码输出结果为：

```
输入数字: 10
十进制数为:  10
转换为二进制为:  0b1010
转换为八进制为:  0o12
转换为十六进制为:  0xa
```

```
(venv) yuanpingdeAir:venv yuanping$ python3 hello_world.py 
输入数字: 13
十进制数为:  13
转换为二进制为:  0b1101
转换为八进制为:  0o15
转换为十六进制为:  0xd
(venv) yuanpingdeAir:venv yuanping$ 
```



## 21.Python ASCII码与字符相互转换

以下代码用于实现ASCII码与字符相互转换：

```python
# 用户输入字符
c = input('请输入一个字符: ')
# 用户输入ASCII码，并将输入的数字转换为整型
a = int(input('请输入一个ASCII码: '))

print(c + ' 的ASCII 码为',ord(c))
print(a, ' 对应的字符为', chr(a))
```

执行以上代码输出结果为：

```python
(venv) yuanpingdeAir:venv yuanping$ python3 hello_world.py 
请输入一个字符: a
请输入一个ASCII码: 101
a 的ASCII 码为 97
101  对应的字符为 e
(venv) yuanpingdeAir:venv yuanping$ 
```



## 22. Python 最大公约数算法

以下代码用于实现最大公约数算法：

```python
# 定义一个函数
def hcf(x, y):
    '''该函数返回两个数的最大公约数'''
    # 获取最小值
    if x > y:
        smaller = y
    else:
        smaller = x

    for i in range(1, smaller + 1):
        if ((x % i == 0) and (y % i == 0)):
            hcf = i

    return  hcf

# 用书输入两个数字
num1 = int(input('输入第一个数字: '))
num2 = int(input('输入第二个数字: '))
print(num1, '和', num2, '的最大公约数为', hcf(num1, num2))
```

执行以上代码输出结果为：

```
输入第一个数字: 54
输入第二个数字: 24
54 和 24 的最大公约数为 6
```



## 23.Python 最小公倍数算法

以下代码用于实现最小公倍数算法：

```python
# 定义函数
def lcm(x, y):
    # 获取最大的数
    if x > y:
        greater = x
    else:
        greater = y

    while(True):
        if ((greater % x == 0) and (greater % y == 0)):
            lcm = greater
            break
        greater += 1

    return  lcm

# 获取用户输入
num1 = int(input('输入第一个数字: '))
num2 = int(input('输入第二个数字: '))
print(num1, '和', num2, '的最小公倍数为', lcm(num1, num2))
```

执行以上代码输出结果为：

```python
输入第一个数字: 52
输入第二个数字: 39
52 和 39 的最小公倍数为 156
```



## 24. Python 简单计算器实现