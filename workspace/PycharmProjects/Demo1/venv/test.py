
# -*- coding: UTF-8 -*-

#!/usr/bin/python3
# Filename: test.py
# author by:univer2012

###MARK: ======= 5.Python 计算三角形的面积
a = float(input(('输入三角形第一边长: ')))
b = float(input(('输入三角形第二边长: ')))
c = float(input(('输入三角形第三边长: ')))
# 计算半周长
s = (a + b + c) / 2
# 计算面积
area = (s*(s-a)*(s-b)*(s-c)) ** 0.5
print('三角形面积为 %0.2f' %area)




###MARK: ======= 4.Python 二次方程
# # 二次方程式 ax**2 + bx + c = 0
# # a、b、c 用户提供，为实数，a ≠ 0
#
# # 导入cmath（复杂数学运算）模块
#
# import  cmath
# a  = float(input('输入 a: '))
# b  = float(input('输入 b: '))
# c  = float(input('输入 c: '))
#
# #计算
# d = (b**2) - (4*a*c)
# #两种求解方式
# sol1 = (-b-cmath.sqrt(d))/(2*a)
# sol2 = (-b+cmath.sqrt(d))/(2*a)
#
# print('结果为 {0} 和 {1}'.format(sol1, sol2))




###MARK: ======= 3.Python 平方根
# num = float(input('请输入一个数字：'))
# num_sqrt = num ** 0.5
# print(' %0.3f 的平方根为 %0.3f' %(num,num_sqrt))


# # 计算实数和复数平方根
# # 导入复数数学模块
#
# import cmath
# num = int(input('请输入一个数字: '))
# num_sqrt = cmath.sqrt(num)
# print('{0} 的平方根为 {1:0.3f} + {2:0.3f}j'.format(num, num_sqrt.real, num_sqrt.imag))






###MARK: ======= 2.Python 数字求和
# #用户输入数字
# num1 = input('输入第一个数字：')
# num2 = input('输入第二个数字：')
# # 求和
# sum = float(num1) + float(num2)
# # 显示计算结果
# print('数字{0}和{1}相加结果为：{2}'.format(num1, num2, sum))

# print('两数之和为 %.1f ' %(float(input('输入第一个数字：')) + float(input('输入第二个数字：'))) )