#!/usr/bin/python3

class Error(Exception):
    """Base class for exceptions in this module."""
    pass

class InputError(Error):
    """Exception raised for errors in the input.

    Attributes:
        expression -- input expression in which the error occurred
        message -- explanation of the error
    """

    def __init__(self, expression, message):
        self.expression = expression
        self.message = message

class TransitionError(Error):
    """"""



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


