来自：[Python3 条件控制](https://www.runoob.com/python3/python3-conditional-statements.html)



Python 条件语句是通过一条或多条语句的执行结果（`True` 或者 `False`）来决定执行的代码块。

 可以通过下图来简单了解条件语句的执行过程:

 ![img](https://www.runoob.com/wp-content/uploads/2013/11/if-condition.jpg) 

代码执行过程：

![img](https://static.runoob.com/images/mix/python-if.webp)

------

## if 语句

Python中if语句的一般形式如下所示：

```python
if condition_1:
    statement_block_1
elif condition_2:
    statement_block_2
else:
    statement_block_3
```



- 如果 "condition_1" 为 `True` 将执行 "statement_block_1" 块语句
- 如果 "condition_1" 为`False`，将判断 "condition_2"
- 如果"condition_2" 为 True 将执行 "statement_block_2" 块语句
- 如果 "condition_2" 为False，将执行"statement_block_3"块语句

 Python 中用 **elif** 代替了 **else if**，所以if语句的关键字为：**if – elif – else**。 

 **注意：**

-  1、每个条件后面要使用冒号 :，表示接下来是满足条件后要执行的语句块。
-  2、使用缩进来划分语句块，相同缩进数的语句在一起组成一个语句块。
-  3、在Python中没有switch – case语句。

Gif 演示：

![img](https://www.runoob.com/wp-content/uploads/2014/05/006faQNTgw1f5wnm0mcxrg30ci07o47l.gif)

### 实例

以下是一个简单的 if 实例：