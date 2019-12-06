
###MARK: ======= 24. Python 简单计算器实现
# 定义函数
def add(x, y):
    '''相加'''


###MARK: ======= 23.Python 最小公倍数算法
# # 定义函数
# def lcm(x, y):
#     # 获取最大的数
#     if x > y:
#         greater = x
#     else:
#         greater = y
#
#     while(True):
#         if ((greater % x == 0) and (greater % y == 0)):
#             lcm = greater
#             break
#         greater += 1
#
#     return  lcm
#
# # 获取用户输入
# num1 = int(input('输入第一个数字: '))
# num2 = int(input('输入第二个数字: '))
# print(num1, '和', num2, '的最小公倍数为', lcm(num1, num2))


###MARK: ======= 22. Python 最大公约数算法
# # 定义一个函数
# def hcf(x, y):
#     '''该函数返回两个数的最大公约数'''
#     # 获取最小值
#     if x > y:
#         smaller = y
#     else:
#         smaller = x
#
#     for i in range(1, smaller + 1):
#         if ((x % i == 0) and (y % i == 0)):
#             hcf = i
#
#     return  hcf
#
# # 用书输入两个数字
# num1 = int(input('输入第一个数字: '))
# num2 = int(input('输入第二个数字: '))
# print(num1, '和', num2, '的最大公约数为', hcf(num1, num2))



###MARK: ======= 21.Python ASCII码与字符相互转换
# # 用户输入字符
# c = input('请输入一个字符: ')
# # 用户输入ASCII码，并将输入的数字转换为整型
# a = int(input('请输入一个ASCII码: '))
#
# print(c + ' 的ASCII 码为',ord(c))
# print(a, ' 对应的字符为', chr(a))


###MARK: ======= 20.Python 十进制转二进制、八进制、十六进制
# # 获取用户输入十进制数
# dec = int(input('输入数字: '))
#
# print('十进制数为: ', dec)
# print('转换为二进制为: ',bin(dec))
# print('转换为八进制为: ',oct(dec))
# print('转换为十六进制为: ',hex(dec))



###MARK: ======= 19.Python 阿姆斯特朗数
# # Python 检测用户输入的数字是否为阿姆斯特朗数
# # 获取用户输入的数字
# num = int(input('请输入一个数字: '))
# # 初始化变量 sum
# sum = 0
# # 指数
# n = len(str(num))
#
# # 检测
# temp = num
# while temp > 0:
#     digit = temp % 10
#     sum += digit ** n
#     temp //= 10
#
# # 输出结果
# if num == sum:
#     print(num, '是阿姆斯特朗数')
# else:
#     print(num, '不是阿姆斯特朗数')



# # 获取用户输入数字
# lower = int(input('最小值: '))
# upper = int(input('最大值: '))
#
# for num in range(lower, upper + 1):
#     # 初始化 sum
#     sum = 0
#     # 指数
#     n = len(str(num))
#
#     # 检测
#     temp = num
#     while temp > 0:
#         digit = temp % 10
#         sum += digit ** n
#         temp //= 10
#
#     if num == sum:
#         print(num)



###MARK: ======= 18.Python 斐波那契数列
# # Python 斐波那契数列实现
# # 获取用户输入数据
# nterms = int(input('你需要几项？'))
#
# # 第一和第一项
# n1 = 0
# n2 = 1
# count = 2
# # 判断输入的值是否合法
# if nterms <= 0:
#     print('请输入一个正整数')
# elif nterms == 1:
#     print('斐波那契数列：')
#     print(n1)
# else:
#     print('斐波那契数列：')
#     print(n1, ',', n2, end= ' , ')
#     while count < nterms:
#         nth = n1 + n2
#         print(nth, end= ' , ')
#         # 更新值
#         n1 = n2
#         n2 = nth
#         count += 1



###MARK: ======= 17.Python 九九乘法表
# # 九九乘法表
# for i in range(1, 10):
#     for j in range(1, i+1):
#         print('{}x{}={}\t'.format(j,i, i*j), end='')
#     print()



###MARK: ======= 16.Python 阶乘实例
# # 通过用户输入数字计算阶乘
# # 获取用户输入的数字
# num = int(input('请输入一个数字: '))
# factorial = 1
#
# # 查看数字是负数， 0 或 正数
# if num < 0:
#     print('抱歉，负数没有阶乘')
# elif num == 0:
#     print('0 的阶乘为 1')
# else:
#     for i in range(1, num + 1):
#         factorial = factorial * i
#     print('%d 的阶乘为 %d' %(num, factorial))



###MARK: ======= 15.Python 输出指定范围内的素数
# # 输出指定范围内的素数
# lower = int(input('输入区间最小值: '))
# upper = int(input('输入区间最大值: '))
#
# for num in range(lower, upper + 1):
#     # 素数大于 1
#     if num > 1:
#         for i in range(2, num):
#             if (num % i) == 0:
#                 break
#         else:
#             print(num)


###MARK: ======= 14.Python 质数判断
# # Python 程序用于检测用户输入的数字是否为质数
# # 用户输入数字
# num = int(input('请输入一个数字: '))
#
# # 质数大于 1
# if num > 1:
#     # 查看因子
#     for i in range(2, num):
#         if (num % i) == 0:
#             print(num, '不是质数')
#             print(i , '乘于', num // i, '是', num)
#             break
#     else:
#         print(num, '是质数')
#
# # 如果输入的数字小于或等于1， 不是质数
# else:
#     print(num, '不是质数')



###MARK: ======= 13.Python 获取最大值函数
# # 最简单的
# print(max(1, 2))
# print(max('a', 'b'))
#
# # 也可以对列表和元组使用
# print(max([1,2]))
# print(max((1,2)))
#
# # 更多实例
# print("80, 100, 1000 最大值为: ", max(80, 100, 1000))
# print("-20, 100, 400 最大值为: ", max(-20, 100, 400))
# print("-80, -20, -10 最大值为: ", max(-80, -20, -10))
# print("0, 100, -400 最大值为: ", max(0, 100, -400))



###MARK: ======= 12.Python 判断闰年
# year = int(input('输入一个年份: '))
# if (year % 4) == 0:
#     if (year % 100) == 0:
#         if (year % 400) == 0:               # 整百年能被400整除的是闰年
#             print('{0} 是闰年'.format(year))
#         else:
#             print('{0} 不是闰年'.format(year))
#     else:
#         print('{0} 是闰年'.format(year))       # 非整百年能被4整除的为闰年
# else:
#     print('{0} 不是闰年'.format(year))



###MARK: ======= 11.Python 判断奇数偶数
# num = int(input('输入一个数字: '))
# if (num % 2) == 0:
#     print('{0} 是偶数'.format(num))
# else:
#     print('{0} 是奇数'.format(num))





# #!/usr/bin/python3
# a = 10
# def test(a):
#     a = a + 1
#     print(a)
#
# test(a)






# #!/usr/bin/python3
# def outer():
#     num = 10
#     def inner():
#         nonlocal num  # nonlocal关键字声明
#         num = 100
#         print(num)
#     inner()
#     print(num)
#
# outer()





# #!/usr/bin/python3
# num = 1
# def fun1():
#     global num # 需要使用 global 关键字声明
#     print(num)
#     num = 123
#     print(num)
#
# fun1()
# print(num)




# #!/usr/bin/python3
# total = 0  # 这是一个全局变量
# # 可写函数说明
# def sum(arg1, arg2):
#     #返回2个参数的和
#     total = arg1 + arg2 # total在这里是局部变量
#     print('函数内是局部变量 : ', total)
#     return  total
#
# # 调用sum函数
# sum(10, 20)
# print('函数外是全局变量 : ',total)





# # var1 是全局名称
# var 1 = 5
# def some_func():
#
#     #var2 是局部名称
#     var2 = 6
#     def some_inner_func():
#
#         # var3 是内嵌的局部名称
#         var3 = 7







# #!/usr/bin/python3
# class Vector:
#     def __init__(self,a,b):
#         self.a = a
#         self.b = b
#
#     def __str__(self):
#         return 'Vector (%d,%d)' %(self.a, self.b)
#
#     def __add__(self, other):
#         return Vector(self.a + other.a, self.b + other.b)
#
# v1 = Vector(2,10)
# v2 = Vector(5,-2)
# print(v1 + v2)





# #!/usr/bin/python3
# class Site:
#     def __init__(self, name, url):
#         self.name = name
#         self.__url = url
#
#     def who(self):
#         print('name :',self.name)
#         print('url :',self.__url)
#
#     def __foo(self):        # 私有方法
#         print('这是私有方法')
#
#     def foo(self):
#         print('这是公共方法')
#         self.__foo()
#
# x = Site('菜鸟教程', 'www.runoob.com')
# x.who()         # 正常输出
# x.foo()         # 正常输出
# x.__foo()       # 报错


# #!/usr/bin/python3
# class JustCounter:
#     __secretCount = 0       # 私有变量
#     publicCount = 0         # 公开变量
#
#     def count(self):
#         self.__secretCount += 1
#         self.publicCount += 1
#         print(self.__secretCount)
#
# counter = JustCounter()
# counter.count()
# counter.count()
# print(counter.publicCount)
# print(counter.__secretCount)    # 报错，实例不能访问私有变量






# #!/usr/bin/python3
#
# class Parent:           # 定义父类
#     def myMethod(self):
#         print('调用父类方法')
#
# class Child(Parent):    # 定义子类
#     def myMethod(self):
#         print('调用子类方法')
#
# c = Child()     # 子类实例
# c.myMethod()    # 子类调用重写方法
# super(Child,c).myMethod()   #用子类对象调用父类已被覆盖的方法





# #!/usr/bin/python3
#
# #类定义
# class people:
#     #定义基本属性
#     name = ''
#     age = 0
#     #定义私有属性，私有属性在类外部无法直接进行访问
#     __weight = 0
#     #定义构造方法
#     def __init__(self,n,a,w):
#         self.name = n
#         self.age = a
#         self.__weight = w
#     def speak(self):
#         print('%s 说: 我 %d 岁。'%(self.name, self.age))
#
# #单继承示例
# class student(people):
#     grade = ''
#     def __init__(self,n,a,w,g):
#         #调用父类的构函
#         people.__init__(self,n,a,w)
#         self.grade = g
#     #覆写父类的方法
#     def speak(self):
#         print('%s 说: 我 %d 岁，我在读 %d 年级'%(self.name, self.age, self.grade))
#
# # 另一个类，多重继承之前的准备
# class speaker():
#     topic = ''
#     name = ''
#     def __init__(self,n,t):
#         self.name = n
#         self.topic = t
#     def speak(self):
#         print('我叫 %s，我是一个演说家，我演讲的主题是 %s'%(self.name, self.topic))
#
# #多重继承
# class sample(speaker, student):
#     a = ''
#     def __init__(self,n,a,w,g,t):
#         student.__init__(self,n,a,w,g)
#         speaker.__init__(self, n, t)
#
# test = sample('Tim', 25, 80,4, 'Python')
# test.speak()    #方法名同，默认调用的是在括号中排前地父类的方法









# class Test:
#     def prt(runoob):
#         print(runoob)
#         print(runoob.__class__)
#
# t = Test()
# t.prt()



# class Complext:
#     def __init__(self, realpart, imagpart):
#         self.r = realpart
#         self.i = imagpart
#
# x = Complext(3.0, -4.5)
# print(x.r, x.i)  # 输出结果：3.0 -4.5






# class MyClass:
#     '''一个简单的实例'''
#     i = 12345
#     def f(self):
#         return 'hello world'
#
#     def __init__(self):
#         self.data = []
#
# # 实例化类
# x = MyClass()
#
# # 访问类的属性和方法
# print('MyClass 类的属性 i 为：',x.i)
# print('MyClass 类的方法 f 输出为：',x.f())



# with open('myfile.txt') as f:
#     for line in f:
#         print(line, end='')



# for line in open('myfile.txt'):
#     print(line,end='')




# class Error(Exception):
#     """Base class for exceptions in this module."""
#     pass
#
# class InputError(Error):
#     """Exception raised for errors in the input.
#
#     Attributes:
#         expression -- input expression in which the error occurred
#         message -- explanation of the error
#     """
#
#     def __init__(self, expression, message):
#         self.expression = expression
#         self.message = message
#
# class TransitionError(Error):
#     """Raised when an operation attempts a state transition that's not
#     allowed.
#
#     Attributes:
#         previous -- state at beginning of transition
#         next -- attempted new state
#         message -- explanation of why the specific transition is not allowed
#     """
#     def __init__(self,previous, next, message):
#         self.previous = previous
#         self.next = next
#         self.message = message





"""
x = 10
if x > 5:
    raise Exception('x 不能大于 5。x 的值为: {}'.format(x))
"""





'''
try:
    runoob()
except AssertionError as error:
    print(error)
else:
    try:
        with open('file.log') as file:
            read_data = file.read()
    except FileExistsError as fnf_error:
        print(fnf_error)
    finally:
        print('这句话，无论异常是否发生都会执行')
'''

"""
import sys

for arg in sys.argv[1:]:
    try:
        f = open(arg, 'r')
    except IOError:
        print('cannot open',arg)
    else:
        print(arg, 'has', len(f.readlines()), 'lines')
        f.close()
"""





"""
import  sys

try:
    f = open('myfile.txt')
    s = f.readline()
    i = int(s.strip())
except OSError as err:
    print('OS error: {0}'.format(err))
except ValueError:
    print('Could not convert data to an integer.')
except:
    print('Unexpected error:', sys.exc_info()[0])
    raise
"""


'''
while True:
    try:
        x = int(input('请输入一个数字:'))
        break
    except ValueError:
        print('您输入的不是数字，请再次尝试输入!')
'''




'''
import pprint, pickle

# 使用pickle模块从文件中重构python对象
pkl_file = open('data.pkl', 'rb')

data1 = pickle.load(pkl_file)
pprint.pprint(data1)

data2 = pickle.load(pkl_file)
pprint.pprint(data2)

pkl_file.close()
'''


