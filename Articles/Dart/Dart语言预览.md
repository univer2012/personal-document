# Dart 语法预览

来自：[Dart 语法预览](http://dart.goodev.org/guides/language/language-tour)

---

本页内容告诉你如何使用 Dart 语言的主要特性，从变量到操作符、 从类到库，我们假定你在阅读本页内容之前已经 了解过其他编程语言了。

关于 Dart 核心库的更多内容，请参考[ Dart 核心库预览](http://dart.goodev.org/guides/libraries/library-tour)。

> 注意： 下面所介绍的大部分特性都可以在 [DartPad](http://dart.goodev.org/tools/dartpad) 中运行。
> 
如果你需要了解语言特性的更详细的细节， 请查看 [Dart 语言规范](http://dart.goodev.org/guides/language/spec) 。

## A basic Dart program（一个最基本的 Dart 程序）

下面的代码使用了很多 Dart 中最基本的特性：
```dart
// 定义个方法。
printNumber(num aNumber) {
  print('The number is $aNumber.'); // 在控制台打印内容。
}

// 这是程序执行的入口。
main() {
  var number = 42; // 定义并初始化一个变量。
  printNumber(number); // 调用一个方法。
}
```

* `print()`   一种打印内容的助手方法。
* `'...'` (或者 `"..."`)     字符串字面量。
*  `$variableName` (or `${expression}`)
 ------- 字符串插值：在字符串字面量中引用变量或者表达式。 详情请参考： [Strings](http://dart.goodev.org/guides/language/language-tour#strings)。

 ## Important concepts（重要的概念）
 在学习 Dart 的时候，请牢记下面一些事实和 概念：

 1. 所有能够使用变量引用的都是对象， 每个对象都是一个类的实例。在 Dart 中 甚至连 数字、方法和 null 都是对象。所有的对象都继承于 [Object](https://api.dartlang.org/stable/dart-core/Object-class.html) 类。
 2. 使用静态类型(例如前面示例中的 `num` ) 可以更清晰的表明你的意图，并且可以让静态分析工具来分析你的代码， 但这并不是强制性的。（在调试代码的时候你可能注意到 没有指定类型的变量的类型为 `dynamic`。）
 3. Dart 在运行之前会先解析你的代码。你可以通过使用 类型或者编译时常量来帮助 Dart 去捕获异常以及 让代码运行的更高效。
 4. Dart 支持顶级方法 (例如 `main()`)，**同时还支持在类中定义函数（静态函数和实例函数）。 你还可以在方法中定义方法 （嵌套方法或者局部方法）**。
 5. 同样，Dart 还支持顶级变量，以及 在类中定义变量（静态变量和实例变量）。 实例变量有时候被称之为域（Fields）或者属性（Properties）。
 6. 和 Java 不同的是，Dart 没有 `public`、 `protected`、 和 `private` 关键字。如果一个标识符以 (`_`) 开头，则该标识符 在库内是私有的。详情请参考： [库和可见性](http://dart.goodev.org/guides/language/language-tour#libraries-and-visibility)。
 7. 标识符可以以字母或者 `_` 下划线开头，后面可以是 其他字符和数字的组合。
 8. 有时候 `表达式 expression` 和 `语句 statement` 是有区别的，所以这种情况我们会分别指明每种情况。
 9. Dart 工具可以指出两种问题：警告和错误。 警告只是说你的代码可能有问题， 但是并不会阻止你的代码执行。 错误可以是编译时错误也可以是运行时错误。遇到编译时错误时，代码将 无法执行；运行时错误将会在运行代码的时候导致一个 [异常](http://dart.goodev.org/guides/language/language-tour#exceptions)。

## Keywords（关键字）
下表为 Dart 语言的关键字。

| abstract<sup>1</sup> | continue | false      | new      | this   |
| -------- | -------- | ---------- | -------- | ------ |
| as<sup>1</sup> | default  | final      | null     | throw  |
| assert   | deferred<sup>1</sup> | finally    | operator<sup>1</sup> | true   |
| async<sup>2</sup> | do       | for        | part<sup>1</sup> | try    |
| async\*<sup>2</sup> | dynamic<sup>1</sup> | get<sup>1</sup> | rethrow   | typedef<sup>1</sup> |
| await<sup>2</sup> | else     | if         | return   | var    |
| break    | enum     | implements<sup>1</sup> | set<sup>1</sup> | void   |
| case     | export<sup>1</sup> | import<sup>1</sup> | static<sup>1</sup> | while  |
| catch    | external<sup>1</sup> | in         | super    | with   |
| class    | extends  | is         | switch   | yield<sup>2</sup> |
| const    | factory<sup>1</sup> | library<sup>1</sup> | sync* <sup>2</sup> | yield\* <sup>2</sup> |

<sup>1</sup> 带有上标 **1**的关键字是*内置关键字*。避免把内置关键字当做标识符使用。 也不要把内置关键字 用作类名字和类型名字。 有些内置关键字是为了方便把 JavaScript 代码移植到 Dart 而存在的。 例如，如果 JavaScript 代码中有个变量的名字为 `factory`， 在移植到 Dart 中的时候，你不必重新命名这个变量。



<sup>2</sup> 带有上标 **2**的关键字，是在 Dart 1.0 发布以后又新加的，用于 支持异步相关的特性。 你不能在标记为`async`、 `async*`、或者 `sync*`的方法体内 使用 `async`、 `await`、或者 `yield`作为标识符。 详情请参考：[异步支持](http://dart.goodev.org/guides/language/language-tour#asynchrony-support)。

所以其他单词都是 *保留词*。 你不能用保留词作为关键字。

## Variables（变量）



下面是声明变量并赋值的示例：

```dart
var name = 'Bob';
```

变量是一个引用。上面名字为 `name`的变量引用了 一个内容为 “Bob” 的 String 对象。



### Default value（默认值）

没有初始化的变量自动获取一个默认值为 `null`。类型为数字的 变量如何没有初始化其值也是 null，不要忘记了 数字类型也是对象。

```dart
int lineCount;
assert(lineCount == null);
// Variables (even if they will be numbers) are initially null.
```

>  **注意：**在生产模式 `assert()`语句被忽略了。在检查模式`assert(*condition*)`会执行，如果条件不为 true 则会抛出一个异常。详情请参考[Assert](http://dart.goodev.org/guides/language/language-tour#assert)部分。

### Optional types（可选的类型）

在声明变量的时候，你可以选择**加上具体 类型**：

```dart
String name = 'Bob';
```

添加类型可以更加清晰的表达你的意图。 IDE 编译器等工具有可以使用类型来更好的帮助你， 可以提供代码补全、提前发现 bug 等功能。

> **注意：**对于局部变量，这里准守[代码风格推荐](http://dart.goodev.org/guides/language/effective-dart/design#type-annotations)部分的建议，使用 `var`而不是具体的类型来定义局部变量。

### Final and const

如果你以后不打算修改一个变量，使用 `final`或者 `const`。 一个 final 变量只能赋值一次；一个 const 变量是编译时常量。 （Const 变量同时也是 final 变量。） 顶级的 final 变量或者类中的 final 变量在 第一次使用的时候初始化。

> **注意：**实例变量可以为 `final`但是不能是 `const`。

下面是 final 变量的示例：

```dart
final name = 'Bob'; // Or: final String name = 'Bob';
// name = 'Alice';  // Uncommenting this causes an error
```

`const`变量为编译时常量。 **如果 const 变量在类中，请定义为 `static const`**。 可以直接定义 const 和其值，也 可以定义一个 `const` 变量使用其他 `const` 变量的值来初始化其值。

```dart
const bar = 1000000;       // Unit of pressure (dynes/cm2)
const atm = 1.01325 * bar; // Standard atmosphere	
```

`const`关键字不仅仅只用来定义常量。 有可以用来创建不变的值， 还能定义构造函数为 `const` 类型的，这种类型 的构造函数创建的对象是不可改变的。任何变量都可以有一个不变的值。

```dart
// Note: [] creates an empty list.
// const [] creates an empty, immutable list (EIA).
var foo = const [];   // foo is currently an EIA.
final bar = const []; // bar will always be an EIA.
const baz = const []; // baz is a compile-time constant EIA.

// You can change the value of a non-final, non-const variable,
// even if it used to have a const value.
foo = [];

// You can't change the value of a final or const variable.
// bar = []; // Unhandled exception.
// baz = []; // Unhandled exception.
```

关于使用 `const`来创建不变的值的更多信息，请参考：[Lists](http://dart.goodev.org/guides/language/language-tour#lists)、 [Maps](http://dart.goodev.org/guides/language/language-tour#maps)、 和 [Classes](http://dart.goodev.org/guides/language/language-tour#classes)。



## Built-in types(内置的类型)

Dart 内置支持下面这些类型：

- numbers
- strings
- booleans
- lists (也被称之为 *arrays*)
- maps
- runes (用于在字符串中表示 Unicode 字符)
- symbols

你可以直接使用字母量来初始化上面的这些类型。 例如 `'this is a string'`是一个字符串字面量，`true`是一个布尔字面量。

由于 Dart 中每个变量引用的都是一个对象 --- 一个类的实例， 你通常使用构造函数来初始化变量。 一些内置的类型具有自己的构造函数。例如， 可以使用 `Map()`构造函数来创建一个 map， 就像这样 `new Map()`。

### Numbers（数值）

Dart 支持两种类型的数字：

- [`int`](https://api.dartlang.org/stable/dart-core/int-class.html)

  整数值，其取值通常位于 -253和 253之间。

- [`double`](https://api.dartlang.org/stable/dart-core/double-class.html)

  64-bit (双精度) 浮点数，符合 IEEE 754 标准。

**`int`和 `double`都是[`num`](https://api.dartlang.org/stable/dart-core/num-class.html)的子类**。 num 类型定义了基本的操作符，例如 +, -, /, 和 *， 还定义了 `abs()`、`ceil()`、和 `floor()`等 函数。 (位操作符，例如 >> 定义在 `int`类中。) 如果 num 或者其子类型不满足你的要求，请参考[dart:math](https://api.dartlang.org/stable/dart-math/dart-math-library.html)库。

> **注意：**不在 -253到 253范围内的整数在 Dart 中的行为 和 JavaScript 中表现不一样。 原因在于 Dart 具有任意精度的整数，而 JavaScript 没有。 参考 [问题 1533](https://github.com/dart-lang/sdk/issues/1533)了解更多信息。



整数是不带小数点的数字。下面是一些定义 整数的方式：

```dart
var x = 1;
var hex = 0xDEADBEEF;
//The integer literal 34653456... can't be represented in 64 bits.
//  var bigInt = 34653465834652437659238476592374958739845729;
```

如果一个数带小数点，则其为 double， 下面是定义 double 的一些方式：

```dart
var y = 1.1;
var exponents = 1.42e5; // 1.42 * 10^5
```

下面是**字符串和数字之间转换**的方式：

```dart
// String -> int
var one = int.parse('1');
assert(one == 1);

// String -> double
var onePointOne = double.parse('1.1');
assert(onePointOne == 1.1);

// int -> String
String oneAsString = 1.toString();
assert(oneAsString == '1');

// double -> String
String piAsString = 3.14159.toStringAsFixed(2);
assert(piAsString == '3.14');
```

整数类型**支持传统的位移操作符**，(`<<`,` >>`), AND (`&`), 和 OR (`|`) 。例如：

```dart
assert((3 << 1) == 6);  // 0011 << 1 == 0110
assert((3 >> 1) == 1);  // 0011 >> 1 == 0001
assert((3 | 4)  == 7);  // 0011 | 0100 == 0111
```

数字字面量为编译时常量。 很多算术表达式 只要其操作数是常量，则表达式结果 也是编译时常量。

```dart
const msPerSecond = 1000;
const secondsUntilRetry = 5;
const msUntilRetry = secondsUntilRetry * msPerSecond;
```

### Strings（字符串）

**Dart 字符串是 UTF-16 编码的字符序列**。 可以使用单引号或者双引号来创建字符串：

```dart
var s1 = 'Single quotes work well for string literals.';	//单引号
var s2 = "Double quotes work just as well.";	//双引号
var s3 = 'It\'s easy to escape the string delimiter.';
var s4 = "It's even easier to use the other delimiter.";
```

可以在字符串中使用表达式，用法是这样的：`${`*expression*`}`。如果表达式是一个比赛服，可以省略 {}。 如果表达式的结果为一个对象，则 Dart 会调用对象的`toString()`函数来获取一个字符串。

```dart
var s = 'string interpolation';

assert('Dart has $s, which is very handy.' ==
       'Dart has string interpolation, ' +
       'which is very handy.');
assert('That deserves all caps. ' +
       '${s.toUpperCase()} is very handy!' ==
       'That deserves all caps. ' +
       'STRING INTERPOLATION is very handy!');
```

> **注意：**`==`操作符判断两个对象的内容是否一样。 如果两个字符串包含一样的字符编码序列， 则他们是相等的。

可以**使用 `+`操作符来把多个字符串链接为一个**，也可以把多个 字符串放到一起来实现同样的功能：

```dart
var s1 = 'String ' 'concatenation'
         " works even over line breaks.";
assert(s1 == 'String concatenation works even over '
             'line breaks.');	//这个拼接很特别

var s2 = 'The + operator '
         + 'works, as well.';
assert(s2 == 'The + operator works, as well.');
```

**使用三个单引号或者双引号也可以 创建多行字符串对象**：

```dart
var s1 = '''
You can create
multi-line strings like this one.
''';

var s2 = """This is also a
multi-line string.""";
```

通过提供一个 `r`前缀可以创建一个 “原始 raw” 字符串：

```dart
var s = r"In a raw string, even \n isn't special.";
  print(s);
  //output: In a raw string, even \n isn't special.
```

参考 [Runes](http://dart.goodev.org/guides/language/language-tour#runes)来了解如何在字符串 中表达 Unicode 字符。



字符串字面量是编译时常量， 带有字符串插值的字符串定义，**若干插值表达式引用的为编译时常量则其结果也是编译时常量。**

```dart
// These work in a const string.
const aConstNum = 0;
const aConstBool = true;
const aConstString = 'a constant string';

// These do NOT work in a const string.
var aNum = 0;
var aBool = true;
var aString = 'a string';
const aConstList = const [1, 2, 3];

const validConstString = '$aConstNum $aConstBool $aConstString';
// const invalidConstString = '$aNum $aBool $aString $aConstList';	//不是常量
```

使用字符串的更多信息请参考：[字符串和正则表达式](http://dart.goodev.org/guides/libraries/library-tour#strings-and-regular-expressions)。



### Booleans（布尔值）

为了代表布尔值，Dart 有一个名字为 `bool`的类型。 只有两个对象是布尔类型的：`true`和 `false`所创建的对象， 这两个对象也都是编译时常量。

当 Dart 需要一个布尔值的时候，只有 `true`对象才被认为是 true。 所有其他的值都是 flase。这点和 JavaScript 不一样， 像 `1`、 `"aString"`、 以及 `someObject`等值都被认为是 false。

例如，下面的代码在 JavaScript 和 Dart 中都是合法的代码：

```dart
var name = 'Bob';
if (name) {
  // Prints in JavaScript, not in Dart.
  print('You have a name!');
}
```

如果在 JavaScript 中运行，则会打印出 “You have a name!”，在 JavaScript 中`name`是非 null 对象所以认为是 true。但是**在 Dart 的*生产模式*下 运行，这不会打印任何内容，原因是 `name`被转换为 false了，原因在于`name != true`。 如果在 Dart *检查模式*运行，上面的 代码将会抛出一个异常，表示 `name`变量不是一个布尔值。**



下面是另外一个在 JavaScript 和 Dart 中表现不一致的示例：

```dart
if (1) {
  print('JS prints this line.');
} else {
  print('Dart in production mode prints this line.');
  // However, in checked mode, if (1) throws an
  // exception because 1 is not boolean.
}
```

> **注意：**上面两个示例只能在 Dart 生产模式下运行， 在检查模式下，会抛出异常表明 变量不是所期望的布尔类型。

**Dart 这样设计布尔值，是为了避免奇怪的行为**。很多 JavaScript 代码 都遇到这种问题。 对于你来说，在写代码的时候你不用这些写代码：`if (*nonbooleanValue*)`，你应该显式的 判断变量是否为布尔值类型。例如：

```dart
// Check for an empty string.
var fullName = '';
assert(fullName.isEmpty);

// Check for zero.
var hitPoints = 0;
assert(hitPoints <= 0);

// Check for null.
var unicorn;
assert(unicorn == null);

// Check for NaN.
var iMeantToDoThis = 0 / 0;
assert(iMeantToDoThis.isNaN);
```

### Lists（列表）

也许 *array*（或者有序集合）是所有编程语言中最常见的集合类型。 在 Dart 中数组就是[List](https://api.dartlang.org/stable/dart-core/List-class.html)对象。所以 通常我们都称之为 *lists*。

Dart list 字面量和 JavaScript 的数组字面量类似。下面是一个 Dart list 的示例：

```dart
var list = [1, 2, 3];
```

Lists 的下标索引从 0 开始，第一个元素的索引是 0.`list.length - 1`是最后一个元素的索引。 访问 list 的长度和元素与 JavaScript 中的用法一样：

```dart
var list = [1, 2, 3];
assert(list.length == 3);
assert(list[1] == 2);

list[1] = 1;
assert(list[1] == 1);
```

**在 list 字面量之前添加 `const`关键字，可以 定义一个不变的 list 对象（编译时常量）**：

```dart
var constantList = const [1, 2, 3];
// constantList[1] = 1; // Uncommenting this causes an error.
```

List 类型有很多函数可以操作 list。 更多信息参考 [泛型](http://dart.goodev.org/guides/language/language-tour#generics)和[集合](http://dart.goodev.org/guides/libraries/library-tour#collections)。

### Maps

通常来说，Map 是一个键值对相关的对象。 键和值可以是任何类型的对象。每个 *键*只出现一次， 而一个值则可以出现多次。Dart 通过 map 字面量 和[Map](https://api.dartlang.org/stable/dart-core/Map-class.html)类型支持 map。

下面是一些创建简单 map 的示例：

```dart
var gifts = {
// Keys      Values
  'first' : 'partridge',
  'second': 'turtledoves',
  'fifth' : 'golden rings'
};

var nobleGases = {
// Keys  Values
  2 :   'helium',
  10:   'neon',
  18:   'argon',
};
```

使用 Map 构造函数也可以实现同样的功能：

```dart
var gifts = new Map();
gifts['first'] = 'partridge';
gifts['second'] = 'turtledoves';
gifts['fifth'] = 'golden rings';

var nobleGases = new Map();
nobleGases[2] = 'helium';
nobleGases[10] = 'neon';
nobleGases[18] = 'argon';
```

往 map 中添加新的键值对和在 JavaScript 中的用法一样：

```dart
var gifts = {'first': 'partridge'};
gifts['fourth'] = 'calling birds'; // Add a key-value pair
```

获取 map 中的对象也和 JavaScript 的用法一样：

```dart
var gifts = {'first': 'partridge'};
assert(gifts['first'] == 'partridge');
```

如果所查找的键不存在，则返回 null：

```dart
var gifts = {'first': 'partridge'};
assert(gifts['fifth'] == null);
```

**使用 `.length`来获取 map 中键值对的数目**：

```dart
var gifts = {'first': 'partridge'};
gifts['fourth'] = 'calling birds';
assert(gifts.length == 2);
```

同样使用 `const`可以创建一个 编译时常量的 map：

```dart
final constantMap = const {
  2: 'helium',
  10: 'neon',
  18: 'argon',
};

// constantMap[2] = 'Helium'; // Uncommenting this causes an error.
```

关于 Map 的更多信息请参考[泛型](http://dart.goodev.org/guides/language/language-tour#generics)和[Maps](http://dart.goodev.org/guides/libraries/library-tour#maps)。

### Runes

在 Dart 中，runes 代表字符串的 UTF-32 code points。

Unicode 为每一个字符、标点符号、表情符号等都定义了 一个唯一的数值。 由于 Dart 字符串是 UTF-16 code units 字符序列， 所以在字符串中表达 32-bit Unicode 值就需要 新的语法了。

通常使用 `\uXXXX`的方式来表示 Unicode code point， 这里的 XXXX 是4个 16 进制的数。 例如，心形符号 (♥) 是 `\u2665`。 对于非 4 个数值的情况， 把编码值放到大括号中即可。 例如，笑脸 emoji (😆) 是 `\u{1f600}`。

[String](https://api.dartlang.org/stable/dart-core/String-class.html)类 有一些属性可以提取 rune 信息。`codeUnitAt`和 `codeUnit`属性返回 16-bit code units。 使用 `runes`属性来获取字符串的 runes 信息。

下面是示例演示了 runes、 16-bit code units、和 32-bit code points 之间的关系。 点击运行按钮 ( ![red-run.png](http://dart.goodev.org/assets/red-run-50a66e01c7e7a877dbc06e799d5bc4b73c4dace2926ec17b4493d8c3e939c59a.png)) 查看 runes 。

```dart
void main() {
  var clapping = '\u{1f44f}';
  print(clapping);
  print(clapping.codeUnits);
  print(clapping.runes.toList());

  Runes input = new Runes('\u2665  \u{1f605}  \u{1f60e}  \u{1f47b}  \u{1f596}  \u{1f44d}');
  print(new String.fromCharCodes(input));
}
```

输出结果为：

```dart
👏
[55357, 56399]
[128079]
♥  😅  😎  👻  🖖  👍
```

> **注意：**使用 list 操作 runes 的时候请小心。 根据所操作的语种、字符集等， 这种操作方式可能导致你的字符串出问题。 更多信息参考 Stack Overflow 上的一个问题：[我如何在 Dart 中反转一个字符串？](http://stackoverflow.com/questions/21521729/how-do-i-reverse-a-string-in-dart)

### Symbols

一个 [Symbol](https://api.dartlang.org/stable/dart-core/Symbol-class.html)object 代表 Dart 程序中声明的操作符或者标识符。 你也许从来不会用到 Symbol，但是**该功能对于通过名字来引用标识符的情况 是非常有价值的，特别是混淆后的代码， 标识符的名字被混淆了，但是 Symbol 的名字不会改变。**

使用 Symbol 字面量来获取标识符的 symbol 对象，也就是在标识符 前面添加一个 `#`符号：

```dart
#radix
#bar
```

Symbol 字面量定义是编译时常量。

关于 symbols 的详情，请参考[dart:mirrors - reflection](http://dart.goodev.org/guides/libraries/library-tour#dartmirrors---reflection)。

## Functions（方法）

**Dart 是一个真正的面向对象语言，方法也是对象并且具有一种 类型，[`Function`](https://api.dartlang.org/stable/dart-core/Function-class.html)**。 这意味着，**方法可以赋值给变量，也可以当做其他方法的参数**。 也可以把 Dart 类的实例当做方法来调用。 详情请参考 [Callable classes](http://dart.goodev.org/guides/language/language-tour#callable-classes)。

下面是定义方法的示例：

```dart
class Test {
  var _nobleGases = {1: 'first'};
  bool isNoble(int atomicNumber) {
    return _nobleGases[atomicNumber] != null;
  }
}
```

虽然在 Effective Dart 中推荐[在公开的 APIs 上使用静态类型](http://dart.goodev.org/guides/language/effective-dart/design#do-type-annotate-public-apis)， 你当然也可以选择忽略类型定义：

```dart
class Test {
  var _nobleGases = {1: 'first'};
  isNoble(int atomicNumber) {
    return _nobleGases[atomicNumber] != null;
  }
}
```

对于只有一个表达式的方法，你可以选择 使用缩写语法来定义：

```dart
class Test {
  var _nobleGases = {1: 'first'};

  bool isNoble(atomicNumber) => _nobleGases[atomicNumber] != null;
}
```

这个 `=> *expr*`语法是`{ return *expr*; }`形式的缩写。`=>`形式 有时候也称之为 *胖箭头*语法。

> **注意：**在箭头 (=>) 和冒号 (;) 之间只能使用一个 *表达式*– 不能使用 *语句*。 例如：你不能使用 [if statement](http://dart.goodev.org/guides/language/language-tour#if-and-else)，但是可以 使用条件表达式[conditional expression](http://dart.goodev.org/guides/language/language-tour#conditional-expressions)。

**方法可以有两种类型的参数：必需的和可选的。 必需的参数在参数列表前面， 后面是可选参数。**



### Optional parameters（可选参数）

可选参数可以是**命名参数**或者**基于位置的参数**，**但是这两种参数不能同时当做可选参数**。

#### Optional named parameters（可选命名参数）

调用方法的时候，你可以使用这种形式 `paramName: value`来指定命名参数。例如：

```dart
enableFlags(bold: true, hidden: false);
```

在定义方法的时候，**使用 `{param1, param2, …}`的形式来指定命名参数**：

```dart
class Test {
  /// Sets the [bold] and [hidden] flags to the values
  /// you specify.
  enableFlags({bool bold, bool hidden}) {
    // ...
  }
}
```

#### Optional positional parameters（可选位置参数）

**把一些方法的参数放到 `[]`中就变成可选 位置参数**了：

```dart
String say(String from, String msg, [String device]) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  return result;
}
```

下面是不使用可选参数调用上面方法 的示例：

```dart
assert(say('Bob', 'Howdy') == 'Bob says Howdy');	
```

下面是使用可选参数调用上面方法的示例：

```dart
assert(say('Bob', 'Howdy', 'smoke signal') ==
      'Bob says Howdy with a smoke signal');
```

#### Default parameter values（默认参数值）

在定义方法的时候，**可以使用 `=`来定义可选参数的默认值。 默认值只能是编译时常量**。 如果没有提供默认值，则默认值为 `null`。

下面是设置可选参数默认值的示例：

```dart
/// Sets the [bold] and [hidden] flags to the values you
/// specify, defaulting to false.
void enableFlags({bool bold = false, bool hidden = false}) {
  // ...
}

//调用
// bold will be true; hidden will be false.
enableFlags(bold: true);
```

> **版本问题：**就版本代码可能需要使用一个冒号 (`:`) 而不是 `=`来设置参数默认值。 **原因在于 Dart SDK 1.21 之前的版本，命名参数只支持 `:`。`:`设置命名默认参数值在以后版本中将不能使用，** 所以我们推荐你**使用 =来设置默认值， 并 指定 Dart SDK 版本为 1.21 或者更高的版本。**

下面的示例显示了**如何设置位置参数的默认值**：

```dart
String say(String from, String msg,
    [String device = 'carrier pigeon', String mood]) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  if (mood != null) {
    result = '$result (in a $mood mood)';
  }
  return result;
}

//调用
assert(say('Bob', 'Howdy') ==
    'Bob says Howdy with a carrier pigeon');
```

**还可以使用 list 或者 map 作为默认值**。 下面的示例定义了一个方法 `doStuff()`， 并分别为 `list`和 `gifts`参数指定了 默认值。

```dart
void doStuff(
    {List<int> list = const [1, 2, 3],
    Map<String, String> gifts = const {
      'first': 'paper',
      'second': 'cotton',
      'third': 'leather'
    }}) {
  print('list:  $list');
  print('gifts: $gifts');
}

//调用：
doStuff();
```

### The main() function（入口函数）

每个应用都需要有个顶级的 `main()`入口方法才能执行。`main()`方法的返回值为 `void`并且有个可选的`List<String>`参数。

下面是一个 web 应用的 `main()`方法：

```dart
void main() {
  querySelector("#sample_text_id")
    ..text = "Click me!"
    ..onClick.listen(reverseText); 
}
```

> **注意：**前面代码中的 `..`语法为 [级联调用](http://dart.goodev.org/guides/language/language-tour#cascade-notation-)（cascade）。 **使用级联调用语法， 你可以在一个对象上执行多个操作。**



下面是一个命令行应用的 `main()`方法，并且使用了 方法参数作为输入参数：

```dart
// Run the app like this: dart args.dart 1 test
void main(List<String> arguments) {
  print(arguments);

  assert(arguments.length == 2);
  assert(int.parse(arguments[0]) == 1);
  assert(arguments[1] == 'test');
}
```

你可以使用 [args library](https://pub.dartlang.org/packages/args)来 定义和解析命令行输入的参数数据。

### Functions as first-class objects（一等方法对象）

可以把方法当做参数调用另外一个方法。例如：

```dart
printElement(element) {
  print(element);
}

void main() {
  var list = [1, 2, 3];
// Pass printElement as a parameter.
  list.forEach(printElement);
}
```

方法也可以赋值给一个变量：

```dart
var loudify = (msg) => '!!! ${msg.toUpperCase()} !!!';
assert(loudify('hello') == '!!! HELLO !!!');
```

上面的方法为 下面即将介绍的匿名方法。

### Anonymous functions（匿名方法）

大部分方法都带有名字，例如 `main()`或者 `printElement()`。 你有可以创建没有名字的方法，称之为*匿名方法*，有时候也被称为 *lambda*或者 *closure 闭包*。 你可以把匿名方法赋值给一个变量， 然后你可以使用这个方法，比如添加到集合或者从集合中删除。

匿名函数和命名函数看起来类似— 在括号之间可以定义一些参数，参数使用逗号 分割，也可以是可选参数。 后面大括号中的代码为函数体：

```dart
([[Type] param1[, …]]) {   
  *codeBlock*;
}; 
```

下面的代码定义了一个参数为`i`（该参数没有指定类型）的匿名函数。 list 中的每个元素都会调用这个函数来 打印出来，同时来计算了每个元素在 list 中的索引位置。

```dart
void main() {
  var list = ['apples', 'oranges', 'grapes', 'bananas', 'plums'];
  list.forEach((i) {
    print(list.indexOf(i).toString() + ': ' + i);
  });
}
```

输出j结果如下：

```dart
0: apples
1: oranges
2: grapes
3: bananas
4: plums
```

如果方法只包含一个语句，可以使用胖箭头语法缩写。 把下面的代码粘贴到 DartPad 中运行，可以看到结果是一样的。

```dart
void main() {
  var list = ['apples', 'oranges', 'grapes', 'bananas', 'plums'];
  list.forEach((i) => print(list.indexOf(i).toString() + ': ' + i));
}
```

### Lexical scope（静态作用域）

Dart 是静态作用域语言，变量的作用域在写代码的时候就确定过了。 基本上大括号里面定义的变量就 只能在大括号里面访问，和 Java 作用域 类似。

下面是作用域的一个 示例：

```dart
var topLevel = true;

main() {
  var insideMain = true;

  myFunction() {
    var insideFunction = true;

    nestedFunction() {
      var insideNestedFunction = true;

      assert(topLevel);
      assert(insideMain);
      assert(insideFunction);
      assert(insideNestedFunction);
    }
  }
}
```

注意 `nestedFunction()`可以访问所有的变量， 包含顶级变量

### Lexical closures（词法闭包）

**一个 *闭包*是一个方法对象，不管该对象在何处被调用， 该对象都可以访问其作用域内 的变量。**

**方法可以封闭定义到其作用域内的变量**。 下面的示例中，`makeAdder()`捕获到了变量 `addBy`。 不管你在那里执行 `makeAdder()`所返回的函数，都可以使用 `addBy`参数。

```dart
/// Returns a function that adds [addBy] to the
/// function's argument.
Function makeAdder(num addBy) {
  return (num i) => addBy + i;
}

main() {
  // Create a function that adds 2.
  var add2 = makeAdder(2);

  // Create a function that adds 4.
  var add4 = makeAdder(4);

  assert(add2(3) == 5);
  assert(add4(3) == 7);
}
```

### Testing functions for equality（测试函数是否相等）

下面是测试**顶级方法、静态函数**和实例函数 相等的示例：

```dart
foo() {}               // A top-level function

class A {
  static void bar() {} // A static method
  void baz() {}        // An instance method
}

main() {
  var x;

  // Comparing top-level functions.
  x = foo;
  assert(foo == x);

  // Comparing static methods.
  x = A.bar;
  assert(A.bar == x);

  // Comparing instance methods.
  var v = new A(); // Instance #1 of A
  var w = new A(); // Instance #2 of A
  var y = w;
  x = w.baz;

  // These closures refer to the same instance (#2),
  // so they're equal.
  assert(y.baz == x);

  // These closures refer to different instances,
  // so they're unequal.
  assert(v.baz != w.baz);
}
```

### Return values（返回值）

所有的函数都返回一个值。**如果没有指定返回值，则 默认把语句 `return null;`作为函数的最后一个语句执行。**

## Operators（操作符）

下表是 Dart 中定义的操作符。 很多操作符都可以重载，详情参考[Overridable operators](http://dart.goodev.org/guides/language/language-tour#overridable-operators)。

| 描述                     | 操作符                                                       |
| ------------------------ | ------------------------------------------------------------ |
| unary postfix            | `expr++`   `expr--`   `()`    `[]`    `.`   `?.`             |
| unary prefix             | `-expr`   `!expr`   `~expr`   `++expr`   `--expr`            |
| multiplicative           | `*`    `/`    `%`  `~/`                                      |
| additive                 | `+`    `-`                                                   |
| shift                    | `<<`    `>>`                                                 |
| bitwise AND              | `&`                                                          |
| bitwise XOR              | `^`                                                          |
| bitwise OR               | `|`                                                          |
| relational and type test | `>=`    `>`   `<=`    `<`    `as`   `is`    `is!`            |
| equality                 | `==`    `!=`                                                 |
| logical AND              | `&&`                                                         |
| logical OR               | `||`                                                         |
| if null                  | `??`                                                         |
| conditional              | `expr1? expr2: expr3`                                        |
| cascade                  | `..`                                                         |
| assignment               | `=`    `*=`   `/=`    `~/=`    `%=`    `+=`    `-=`    `<<=`    `>>=`    `&=`    `^=`    `|=`    `??=` |

在使用操作符的时候，就创建了表达式。下面是一些 操作符表达式：

```dart
a++;
a + b;
a = b;
a == b;
a ? b: c;
a is T;
```

**在[操作符表格](http://dart.goodev.org/guides/language/language-tour#operators)中所列的操作符 都是按照优先级顺序从左到右，从上到下的方式来列出的， 上面和左边的操作符优先级要高于下面和右边的**。 例如 `%`操作符优先级高于 `==`，而 `==` 高于 `&&`。所以下面的 代码结果是一样的：

```dart
// 1: Parens improve readability.
if ((n % i == 0) && (d % i == 0))

// 2: Harder to read, but equivalent.
if (n % i == 0 && d % i == 0)
```

> **警告：****对于有两个操作数的操作符，左边的操作数决定了 操作符的功能。** 例如，如果有一个 Vector 对象和一个 Point 对象， `aVector + aPoint`使用的是 Vector 对象中定义的 + 操作符。

### Arithmetic operators（算术操作符）

Dart 支持常用的算术操作符，如下：

| 操作符    | 解释                   |
| --------- | ---------------------- |
| `+`       | 加号                   |
| `–`       | 减号                   |
| `-*expr*` | 负号                   |
| `*`       | 乘号                   |
| `/`       | 除号                   |
| `~/`      | 除号，但是返回值为整数 |
| `%`       | 取模                   |

示例：

```dart
  assert(2 + 3 == 5);
  assert(2 - 3 == -1);
  assert(2 * 3 == 6);
  assert(5 / 2 == 2.5);   // Result is a double
  assert(5 ~/ 2 == 2);    // Result is an integer
  assert(5 % 2 == 1);     // Remainder

  print('5/2 = ${5~/2} r ${5%2}'); // output: 5/2 = 2 r 1
```

Dart 还支持递增、递减前缀 和后缀操作：

| Operator  | Meaning                                             |
| --------- | --------------------------------------------------- |
| `++*var*` | `*var* = *var*+ 1`(expression value is `*var* + 1`) |
| `*var*++` | `*var* = *var*+ 1`(expression value is `*var*`)     |
| `--*var*` | `*var* = *var*– 1`(expression value is `*var* – 1`) |
| `*var*--` | `*var* = *var*– 1`(expression value is `*var*`)     |

示例：

```dart
var a, b;

a = 0;
b = ++a;        // Increment a before b gets its value.
assert(a == b); // 1 == 1

a = 0;
b = a++;        // Increment a AFTER b gets its value.
assert(a != b); // 1 != 0

a = 0;
b = --a;        // Decrement a before b gets its value.
assert(a == b); // -1 == -1

a = 0;
b = a--;        // Decrement a AFTER b gets its value.
assert(a != b); // -1 != 0
```

### Equality and relational operators（相等相关的操作符）

下表是和相等操作相关的操作符。

| 操作符 | 解释     |
| ------ | -------- |
| `==`   | 相等     |
| `!=`   | 不等     |
| `>`    | 大于     |
| `<`    | 小于     |
| `>=`   | 大于等于 |
| `<=`   | 小于等于 |

要测试两个对象代表的是否为同样的内容，使用`==`操作符。(在某些情况下，**你需要知道两个对象是否是同一个对象， 使用 [`identical()`](https://api.dartlang.org/stable/dart-core/identical.html)方法**。) 下面是 `==`操作符工作原理解释：

1. 如果 *x*或者 *y*是 null，如果两个都是 null 则返回 true，如果 只有一个是 null 返回 false。
2. 返回如下函数的返回值 `x.==(y)`。 （你没看错， 像 `==`这种操作符是定义在左边对象上的函数。 你甚至还可以覆写这些操作符。 在后面的[Overridable operators](http://dart.goodev.org/guides/language/language-tour#overridable-operators)将介绍如何做。）

下面是相等关系操作符的 使用示例：

```dart
assert(2 == 2);
assert(2 != 3);
assert(3 > 2);
assert(2 < 3);
assert(3 >= 3);
assert(2 <= 3);
```

### Type test operators（类型判定操作符）

`as`、 `is`、 和 `is!`操作符是在运行时判定对象 类型的操作符：

| 操作符 | 解释                           |
| ------ | ------------------------------ |
| `as`   | 类型转换                       |
| `is`   | 如果对象是指定的类型返回 True  |
| `is!`  | 如果对象是指定的类型返回 False |

**只有当 `obj`实现了 `T`的接口，`obj is T`才是 true**。例如 `obj is Object`总是 true。

使用 `as`操作符把对象转换为特定的类型。 一般情况下，你可以把它当做用 `is`判定类型然后调用 所判定对象的函数的缩写形式。例如下面的 示例：

```dart
if (emp is Person) { // Type check
  emp.firstName = 'Bob';
}
```

使用 `as`操作符可以简化上面的代码：

```dart
(emp as Person).firstName = 'Bob';
```

> **注意：**上面这两个代码效果是有区别的。如果 `emp`是 null 或者不是 Person 类型， 则**第一个示例使用 `is`则不会执行条件里面的代码，而第二个情况使用`as`则会抛出一个异常**。

### Assignment operators（赋值操作符）

使用 `=`操作符来赋值。 但是还有**一个 `??=`操作符用来指定 值为 null 的变量的值**。

```dart
	var a;
  var value = 3;
	var b;
  //var b = 2;
  a = value;    // 给 a 变量赋值
  b ??= value;  // 如果 b 是 null，则赋值给 b；
                // 如果不是 null，则 b 的值保持不变
  print('b = $b');
```

还有复合赋值操作符 `+=`等可以 赋值：

| `=`  | `–=` | `/=`  | `%=`  | `>>=` | `^=` |
| ---- | ---- | ----- | ----- | ----- | ---- |
| `+=` | `*=` | `~/=` | `<<=` | `&=`  | `|=` |

下面是复合赋值操作符工作原理解释：

|                     | 复合赋值操作符 | 相等的表达式  |
| ------------------- | -------------- | ------------- |
| **对于 操作符 op:** | `a *op*= b`    | `a = a *op*b` |
| **示例:**           | `a += b`       | `a = a + b`   |

下面的代码使用赋值操作符合 复合赋值操作符：

```dart
var a = 2;           // Assign using =
a *= 3;              // Assign and multiply: a = a * 3
assert(a == 6);
```

### Logical operators（逻辑操作符）

可以使用逻辑操作符来 操作布尔值：

| 操作符    | 解释                                                  |
| --------- | ----------------------------------------------------- |
| `!*expr*` | 对表达式结果取反（true 变为 false ，false 变为 true） |
| `||`      | 逻辑 OR                                               |
| `&&`      | 逻辑 AND                                              |

下面是使用示例：

```dart
	bool done = false;
  int col = 3;
  if (!done && (col == 0 || col == 3)) {
    print('...Do something...');
  }
  
  // output:  ...Do something...
```

### Bitwise and shift operators（位和移位操作符）

在 Dart 中可以单独操作数字的某一位， 下面操作符同样应用于整数：

| 操作符    | 解释                                                  |
| --------- | ----------------------------------------------------- |
| `&`       | AND                                                   |
| `|`       | OR                                                    |
| `^`       | XOR                                                   |
| `~*expr*` | Unary bitwise complement (0s become 1s; 1s become 0s) |
| `<<`      | Shift left                                            |
| `>>`      | Shift right                                           |

使用位于和移位操作符的示例：

```dart
final value = 0x22;
final bitmask = 0x0f;

assert((value & bitmask)  == 0x02);  // AND
assert((value & ~bitmask) == 0x20);  // AND NOT
assert((value | bitmask)  == 0x2f);  // OR
assert((value ^ bitmask)  == 0x2d);  // XOR
assert((value << 4)       == 0x220); // Shift left
assert((value >> 4)       == 0x02);  // Shift right
```



### Conditional expressions（条件表达式）

Dart 有两个特殊的操作符可以用来替代[if-else](http://dart.goodev.org/guides/language/language-tour#if-and-else)语句：

- `*condition* ? *expr1* : *expr2*`

  如果 *condition*是 true，执行 *expr1*(并返回执行的结果)； 否则执行 *expr2*并返回其结果。

- `*expr1*?? *expr2*`

  如果 *expr1*是 non-null，返回其值； 否则执行 *expr2*并返回其结果。

  

  

**如果你需要基于布尔表达式 的值来赋值， 考虑使用 `?:`。**

```dart
var finalStatus = m.isFinal ? 'final' : 'not final';
```

**如果布尔表达式是测试值是否为 null， 考虑使用 `??`。**

```dart
class Test {
  String msg;
  String toString() => msg ?? super.toString();
}
```

下面是一样效果的实现， 但是代码不是那么简洁：

```dart
// Slightly longer version uses ?: operator.
String toString() => msg == null ? super.toString() : msg;

// Very long version uses if-else statement.
String toString() {
  if (msg == null) {
    return super.toString();
  } else {
    return msg;
  }
}
```

### Cascade notation (..)（级联操作符）

级联操作符 (`..`) 可以在同一个对象上 连续调用多个函数以及访问成员变量。 **使用级联操作符可以避免创建 临时变量， 并且写出来的代码看起来 更加流畅：**

例如下面的代码：

```dart
querySelector('#button') // Get an object.
  ..text = 'Confirm'   // Use its members.
  ..classes.add('important')
  ..onClick.listen((e) => window.alert('Confirmed!'));
```

第一个方法 `querySelector()`返回了一个 selector 对象。 后面的级联操作符都是调用这个对象的成员， 并忽略每个操作 所返回的值。

上面的代码和下面的代码功能一样：

```dart
var button = querySelector('#button');
button.text = 'Confirm';
button.classes.add('important');
button.onClick.listen((e) => window.alert('Confirmed!'));
```

**级联调用也可以嵌套**：

```dart
final addressBook = (new AddressBookBuilder()
      ..name = 'jenny'
      ..email = 'jenny@example.com'
      ..phone = (new PhoneNumberBuilder()
            ..number = '415-555-0100'
            ..label = 'home')
          .build())
    .build();
```

在方法上使用级联操作符需要非常小心， 例如下面的代码就是不合法的：

```dart
void main() {
	// Does not work
  var sb = new StringBuffer();
  sb.write('foo')..write('bar');
}
class StringBuffer {
  String total;

  void write(String str) {
    total ??= '';
    total += str;
  }
}
```

`sb.write()`函数返回一个 `void`， 无法在 `void`上使用级联操作符。



> **注意：**严格来说， 两个点的级联语法不是一个操作符。 只是一个 Dart 特殊语法。

### Other operators（其他操作符）

下面是其他操作符：

| Operator | Name         | Meaning                                                      |
| -------- | ------------ | ------------------------------------------------------------ |
| `()`     | 使用方法     | 代表调用一个方法                                             |
| `[]`     | 访问 List    | 访问 list 中特定位置的元素                                   |
| `.`      | 访问 Member  | 访问元素，例如 `foo.bar`代表访问 `foo`的 `bar`成员           |
| `?.`     | 条件成员访问 | 和 `.` 类似，**但是左边的操作对象不能为 null，例如 `foo?.bar`如果 `foo`为 null 则返回 null，否则返回 `bar` 成员** |

关于 `.`、 `?.`、和 `..`的详情，请参考[Classes](http://dart.goodev.org/guides/language/language-tour#classes)。



## Control flow statements（流程控制语句）

可以使用下面的语句来控制 Dart 代码的流程：

- `if`and `else`
- `for`loops
- `while`and `do`-`while`loops
- `break`and `continue`
- `switch`and `case`
- `assert`

使用 `try-catch`和 `throw`还能影响控制流程的 跳转，详情请参考 [Exceptions](http://dart.goodev.org/guides/language/language-tour#exceptions)。

### If android else

Dart 支持 `if`语句以及可选的 `else`，例如下面的示例。 另参考 [条件表达式](http://dart.goodev.org/guides/language/language-tour#conditional-expressions)。

```dart
if (isRaining()) {
  you.bringRainCoat();
} else if (isSnowing()) {
  you.wearJacket();
} else {
  car.putTopDown();
}
```

注意， Dart 中和 JavaScript 对待 `true`的区别。 参考 [布尔值](http://dart.goodev.org/guides/language/language-tour#booleans)获取更多信息。



### For loops

可以使用标准的 `for`循环：

```dart
void main() {
  var message = new StringBuffer("Dart is fun");
  for (var i = 0; i < 5; i++) {
    message.write('!');
  }
}

class StringBuffer {
  String total;

  StringBuffer(this.total);

  void write(String str) {
    total ??= '';
    total += str;
  }
}
```

Dart `for`循环中的闭包会捕获循环的 index 索引值， 来避免 JavaScript 中常见的问题。例如：

```dart
var callbacks = [];
for (var i = 0; i < 2; i++) {
  callbacks.add(() => print(i));
}
callbacks.forEach((c) => c());
```

输出的结果为所期望的 `0`和 `1`。但是 上面同样的代码在 JavaScript 中会打印两个 `2`。

如果要遍历的对象实现了 Iterable 接口，则可以使用[`forEach()`](https://api.dartlang.org/stable/dart-core/Iterable/forEach.html)方法。**如果没必要当前遍历的索引，则使用 `forEach()`方法 是个非常好的选择**：

```dart
candidates.forEach((candidate) => candidate.interview());
```

List 和 Set 等实现了 Iterable 接口的类还支持 `for-in`形式的[遍历](http://dart.goodev.org/guides/libraries/library-tour#iteration)：

```dart
var collection = [0, 1, 2];
for (var x in collection) {
  print(x);
}
```



### While and do-while

`while`循环在**执行循环之前先判断条件是否满足**：

```dart
while (!isDone()) {
  doSomething();
}
```

而 `do`-`while`循环是**先执行循环代码再判断条件**：

```dart
do {
  printLine();
} while (!atEndOfPage());
```



### Break and continue

**使用 `break`来终止循环**：

```dart
while (true) {
  if (shutDownRequested()) break;
  processIncomingRequests();
}
```

**使用 `continue`来开始下一次循环**：

```dart
for (int i = 0; i < candidates.length; i++) {
  var candidate = candidates[i];
  if (candidate.yearsExperience < 5) {
    continue;
  }
  candidate.interview();
}
```

上面的代码在实现[Iterable](https://api.dartlang.org/stable/dart-core/Iterable-class.html)接口对象上可以使用下面的写法：

```dart
candidates.where((c) => c.yearsExperience >= 5)
          .forEach((c) => c.interview());
```



### Switch and case

Dart 中的 Switch 语句使用 `==`比较 integer、string、或者编译时常量。 比较的对象必须都是同一个类的实例（并且不是 其它类），class 必须没有覆写 `==`操作符。[Enumerated types](http://dart.goodev.org/guides/language/language-tour#enumerated-types)非常适合 在 `switch`语句中使用。



> **注意：**Dart 中的 Switch 语句仅适用于有限的情况， 例如在 解释器或者扫描器中使用。

**每个非空的 `case`语句都必须有一个 `break`语句**。 另外还可以通过 `continue`、 `throw`或 者 `return`来结束非空 `case`语句。

当没有 `case`语句匹配的时候，可以使用 `default`语句来匹配这种默认情况。

```dart
var command = 'OPEN';
switch (command) {
  case 'CLOSED':
    executeClosed();
    break;
  case 'PENDING':
    executePending();
    break;
  case 'APPROVED':
    executeApproved();
    break;
  case 'DENIED':
    executeDenied();
    break;
  case 'OPEN':
    executeOpen();
    break;
  default:
    executeUnknown();
}
```

下面的示例代码在 `case`中省略了 `break`语句， 编译的时候将会出现一个错误：

```dart
var command = 'OPEN';
switch (command) {
  case 'OPEN':
    executeOpen();
    // ERROR: Missing break causes an exception!!

  case 'CLOSED':
    executeClosed();
    break;
}
```

但是，在 Dart 中的<font color=#FF0000>空 `case`语句中可以不要`break`语句</font>：

```dart
var command = 'CLOSED';
switch (command) {
  case 'CLOSED': // Empty case falls through.
  case 'NOW_CLOSED':
    // Runs for both CLOSED and NOW_CLOSED.
    executeNowClosed();
    break;
}
```

<font color=#FF0000>如果你需要实现这种继续到下一个 `case`语句中继续执行，则可以 使用 `continue`语句跳转到对应的标签（label）处继续执行</font>：

```dart
void main() {
  var command = 'CLOSED';
  switch (command) {
    nowClosed:
    case 'NOW_CLOSED':
    // Runs for both CLOSED and NOW_CLOSED.
      executeNowClosed();
      break;

    case 'CLOSED':
      executeClosed();
      continue nowClosed;
  // Continues executing at the nowClosed label.
  }
}
void executeClosed() {
  print('executeClosed');
}
void executeNowClosed() {
  print('executeNowClosed');
}
```

输出结果：

```dart
executeClosed
executeNowClosed
```

每个 `case`语句可以有局部变量，局部变量 只有在这个语句内可见。



### Assert（断言）

**如果条件表达式结果不满足需要，则可以使用 `assert`语句来打断代码的执行**。 下面介绍如何使用断言。 下面是一些示例代码：

```dart
// Make sure the variable has a non-null value.
assert(text != null);

// Make sure the value is less than 100.
assert(number < 100);

// Make sure this is an https URL.
assert(urlString.startsWith('https'));
```

> **注意：**断言只在检查模式下运行有效，如果在生产模式 运行，则断言不会执行。

`assert`方法的参数可以为任何返回布尔值的表达式或者方法。 如果返回的值为 true， 断言执行通过，执行结束。 如果返回值为 false， 断言执行失败，会抛出一个异常[AssertionError](https://api.dartlang.org/stable/dart-core/AssertionError-class.html))。



## Exceptions（异常）

代码中可以出现异常和捕获异常。异常表示一些 未知的错误情况。如果异常没有捕获， 则异常会抛出，导致 抛出异常的代码终止执行。

<font color=#FF0000>和 Java 不同的是，所有的 Dart 异常是非检查异常</font>。 方法不一定声明了他们所抛出的异常， 并且你不要求捕获任何异常。

Dart 提供了[Exception](https://api.dartlang.org/stable/dart-core/Exception-class.html)和[Error](https://api.dartlang.org/stable/dart-core/Error-class.html)类型， 以及一些子类型。你还 可以定义自己的异常类型。但是， Dart 代码可以 抛出任何非 null 对象为异常，不仅仅是实现了 Exception 或者 Error 的对象。



### Throw

下面是**抛出或者 *扔出*一个异常**的示例：

```dart
throw new FormatException('Expected at least 1 section');
```

还可以**抛出任意的对象**：

```dart
throw 'Out of llamas!';
```

由于抛出异常是一个表达式，所以可以在 `=>` 语句中使用，也可以在其他能使用表达式的地方抛出异常。

```dart
distanceTo(Point other) =>
    throw new UnimplementedError();
```



### Catch

捕获异常可以避免异常继续传递（你重新抛出`rethrow`异常除外）。 捕获异常给你一个处理 该异常的机会：

```dart
try {
  breedMoreLlamas();
} on OutOfLlamasException {
  buyMoreLlamas();
}
```



<font color=#FF0000>对于可以抛出多种类型异常的代码，你可以指定 多个捕获语句。每个语句分别对应一个异常类型， 如果捕获语句没有指定异常类型，则 该语句可以捕获任何异常类型</font>：

```dart
try {
  breedMoreLlamas();
} on OutOfLlamasException {
  // A specific exception
  buyMoreLlamas();
} on Exception catch (e) {
  // Anything else that is an exception
  print('Unknown exception: $e');
} catch (e) {
  // No specified type, handles all
  print('Something really unknown: $e');
}
```

如之前代码所示，你可以使用`on`或者 `catch`来声明捕获语句，也可以 同时使用。<font color=#FF0000>使用 `on`来指定异常类型，使用 `catch`来 捕获异常对象</font>。

<font color=#FFFF00>函数 `catch()`可以带有一个或者两个参数， 第一个参数为抛出的异常对象， 第二个为堆栈信息 (一个 [StackTrace](https://api.dartlang.org/stable/dart-core/StackTrace-class.html)对象)</font>。

```dart
try {
  breedMoreLlamas();
} on OutOfLlamasException {
  // A specific exception
  buyMoreLlamas();
} on Exception catch (e) {
  print('Exception details:\n $e');
} catch (e, s) {
  print('Exception details:\n $e');
  print('Stack trace:\n $s');
}
```

使用 `rethrow`关键字可以 把捕获的异常给 重新抛出。

```dart
final foo = '';

void misbehave() {
  try {
    foo = "You can't change a final variable's value.";
  } catch (e) {
    print('misbehave() partially handled ${e.runtimeType}.');
    rethrow; // Allow callers to see the exception.
  }
}

void main() {
  try {
    misbehave();
  } catch (e) {
    print('main() finished handling ${e.runtimeType}.');
  }
}
```



### Finally

**要确保某些代码执行，不管有没有出现异常都需要执行，可以使用 一个 `finally`语句来实现**。<font color=#FF0000>如果没有 `catch`语句来捕获异常， 则在执行完 `finally`语句后， 异常被抛出了</font>：

```dart
try {
  breedMoreLlamas();
} finally {
  // Always clean up, even if an exception is thrown.
  cleanLlamaStalls();
}
```

<font color=#FF0000>定义的 `finally`语句在任何匹配的 `catch`语句之后执行</font>：

```dart
try {
  breedMoreLlamas();
} catch(e) {
  print('Error: $e');  // Handle the exception first.
} finally {
  cleanLlamaStalls();  // Then clean up.
}
```

详情请参考[Exceptions](http://dart.goodev.org/guides/libraries/library-tour#exceptions)部分。











## Classes

Dart 是一个面向对象编程语言，同时支持基于 mixin 的继承机制。 每个对象都是一个类的实例，所有的类都继承于[Object.](https://api.dartlang.org/stable/dart-core/Object-class.html)。*基于 Mixin 的继承*意味着每个类（Object 除外） 都只有一个超类，一个类的代码可以在其他 多个类继承中重复使用。

使用 `new`关键字和构造函数来创建新的对象。 <font color=#FF0000>构造函数名字可以为 `*ClassName*`或者`*ClassName*.*identifier*`</font>。例如：

```dart
var jsonData = JSON.decode('{"x":1, "y":2}');

// Create a Point using Point().
var p1 = new Point(2, 2);

// Create a Point using Point.fromJson().
var p2 = new Point.fromJson(jsonData);
```

对象的成员包括方法和数据 (*函数*和*示例变量*)。当你调用一个函数的时候，你是在一个对象上 *调用*： 函数需要访问对象的方法 和数据。

使用点(`.`)来引用对象的变量或者方法：

```dart
var p = new Point(2, 2);

// Set the value of the instance variable y.
p.y = 3;

// Get the value of y.
assert(p.y == 3);

// Invoke distanceTo() on p.
num distance = p.distanceTo(new Point(4, 4));
```

<font color=#FF0000>使用 `?.`来替代 `.`可以避免当左边对象为 null 时候 抛出异常</font>：

```dart
// If p is non-null, set its y value to 4.
p?.y = 4;
```

有些类提供了常量构造函数。使用常量构造函数 可以创建编译时常量，要使用常量构造函数只需要用 `const`替代 `new`即可：

```dart
var p = const ImmutablePoint(2, 2);
```

<font color=#FF0000>两个一样的编译时常量其实是 同一个对象</font>：

```dart
class ImmutablePoint {
  final int x;
  final int y;
  const ImmutablePoint(this.x, this.y);
}

void main() {
  var a = const ImmutablePoint(1, 1);
  var b = const ImmutablePoint(1, 1);

  assert(identical(a, b)); // They are the same instance!
}
```

<font color=#FF0000>可以使用 Object 的 `runtimeType`属性来判断实例 的类型，该属性 返回一个[Type](https://api.dartlang.org/stable/dart-core/Type-class.html)对象</font>。

```dart
print('The type of a is ${a.runtimeType}');
```



### Instance variables

下面是如何定义实例变量的示例：

```dart
class Point {
  num x; // Declare instance variable x, initially null.
  num y; // Declare y, initially null.
  num z = 0; // Declare z, initially 0.
}
```

所有没有初始化的变量值都是 `null`。

**每个实例变量都会自动生成一个 *getter*方法（隐含的）。 Non-final 实例变量还会自动生成一个 *setter*方法**。详情， 参考 [Getters and setters](http://dart.goodev.org/guides/language/language-tour#getters-and-setters)。

```dart
class Point {
  num x;
  num y;
}

main() {
  var point = new Point();
  point.x = 4;          // Use the setter method for x.
  assert(point.x == 4); // Use the getter method for x.
  assert(point.y == null); // Values default to null.
}
```

<font color=#9400D3>如果你在实例变量定义的时候初始化该变量（不是 在构造函数或者其他方法中初始化），该值是在实例创建的时候 初始化的，也就是在构造函数和初始化参数列 表执行之前</font>。



### Constructors

定义一个和类名字一样的方法就定义了一个构造函数 还可以带有其他可选的标识符，详情参考[Named constructors](http://dart.goodev.org/guides/language/language-tour#named-constructors))（命名构造函数）。 常见的构造函数生成一个 对象的新实例：

```dart
class Point {
  num x;
  num y;

  Point(num x, num y) {
    // There's a better way to do this, stay tuned.
    this.x = x;
    this.y = y;
  }
}
```

`this`关键字指当前的实例。



> **注意：**只有当名字冲突的时候才使用 `this`。否则的话， Dart 代码风格样式推荐忽略 `this`。



由于把构造函数参数赋值给实例变量的场景太常见了， Dart 提供了一个语法糖来简化这个操作：

```dart
class Point {
  num x;
  num y;

  // Syntactic sugar for setting x and y
  // before the constructor body runs.
  Point(this.x, this.y);
}
```



#### Default constructors（默认构造函数）

**如果你没有定义构造函数，则会有个默认构造函数。 默认构造函数没有参数，并且会调用超类的 没有参数的构造函数。**

#### Constructors aren’t inherited（<font color=#FF0000>构造函数不会继承</font>）

子类不会继承超类的构造函数。 子类如果没有定义构造函数，则只有一个默认构造函数 （没有名字没有参数）。

#### Named constructors（命名构造函数）

使用命名构造函数可以为一个类实现多个构造函数， 或者使用命名构造函数来更清晰的表明你的意图：

```dart
class Point {
  num x;
  num y;

  Point(this.x, this.y);

  // Named constructor
  Point.fromJson(Map json) {
    x = json['x'];
    y = json['y'];
  }
}
```



> 注意：构造函数不能继承，<font color=#FF0000>所以超类的命名构造函数 也不会被继承。如果你希望 子类也有超类一样的命名构造函数， 你必须在子类中自己实现该构造函数</font>。



#### Invoking a non-default superclass constructor（调用超类构造函数）

默认情况下，子类的构造函数会自动调用超类的 无名无参数的默认构造函数。 超类的构造函数在子类构造函数体开始执行的位置调用。 如果提供了一个 [initializer list](http://dart.goodev.org/guides/language/language-tour#initializer-list)（初始化参数列表） ，则初始化参数列表在超类构造函数执行之前执行。 <font color=#FF0000>下面是构造函数执行顺序：</font>

1. initializer list（初始化参数列表）
2. superclass’s no-arg constructor（超类的无名构造函数）
3. main class’s no-arg constructor（主类的无名构造函数）



**如果超类没有无名无参数构造函数， 则你_需要手工的调用超类的其他构造函数_**。 <font color=#FF0000>在构造函数参数后使用冒号 (`:`) 可以调用 超类构造函数</font>。

下面的示例中，Employee 类的构造函数调用 了超类 Person 的命名构造函数。 点击运行按钮( ![red-run.png](http://dart.goodev.org/assets/red-run-50a66e01c7e7a877dbc06e799d5bc4b73c4dace2926ec17b4493d8c3e939c59a.png)) 来执行代码。

```dart
class Person {
  String firstName;

  Person.fromJson(Map data) {
    print('in Person');
  }
}

class Employee extends Person {
  // Person does not have a default constructor;
  // you must call super.fromJson(data).
  Employee.fromJson(Map data) : super.fromJson(data) {
    print('in Employee');
  }
}


main() {
  var emp = new Employee.fromJson({});

  // Prints:
  // in Person
  // in Employee
  if (emp is Person) {
    emp.firstName = 'Bob';
  }
}
```



由于超类构造函数的参数在构造函数执行之前执行，所以 参数可以是一个表达式或者 一个方法调用：

```dart
class Employee extends Person {
  // Person does not have a default constructor;
  // you must call super.fromJson(data).
  Employee.fromJson(Map data) : super.fromJson(data) {
    print('in Employee');
  }
  
  Employee() : super.fromJson(findDefaultData());
}
```

> **注意：**如果在构造函数的初始化列表中使用 `super()`，需要把它放到最后。 详情参考[Dart 最佳实践](http://dart.goodev.org/guides/language/effective-dart/usage#do-place-the-super-call-last-in-a-constructor-initialization-list)。

>  **警告：**调用超类构造函数的参数无法访问 `this`。 例如，参数可以为静态函数但是不能是实例函数。



#### Initializer list（初始化列表）

在构造函数体执行之前除了可以调用超类构造函数之外，还可以 初始化实例参数。 使用逗号分隔初始化表达式。

```dart
class Point {
  num x;
  num y;

  Point(this.x, this.y);

  // Initializer list sets instance variables before
  // the constructor body runs.
  Point.fromJson(Map jsonMap)
      : x = jsonMap['x'],
        y = jsonMap['y'] {
    print('In Point.fromJson(): ($x, $y)');
  }
}
```

> **警告：**初始化表达式等号右边的部分不能访问 `this`。

<font color=#FF0000>初始化列表非常适合用来设置 final 变量的值。</font> 下面示例代码中初始化列表设置了三个 final 变量的值。 点击运行按钮 ( ![red-run.png](http://dart.goodev.org/assets/red-run-50a66e01c7e7a877dbc06e799d5bc4b73c4dace2926ec17b4493d8c3e939c59a.png)) 执行代码：

```dart
import 'dart:math';

class Point {
  final num x;
  final num y;
  final num distanceFromOrigin;

  Point(x, y)
  : x = x,
  y = y,
  distanceFromOrigin = sqrt(x * x + y * y);
}

void main() {
  var p = new Point(2, 3);
  print(p.distanceFromOrigin);
  //output: 3.605551275463989
}
```



#### Redirecting constructors（重定向构造函数）

有时候一个构造函数会调动类中的其他构造函数。 <font color=#FF0000>一个重定向构造函数是没有代码的，在构造函数声明后，使用 冒号调用其他构造函数。</font>

```dart
class Point {
  num x;
  num y;

  // The main constructor for this class.
  Point(this.x, this.y);

  // Delegates to the main constructor.
  Point.alongXAxis(num x) : this(x, 0);
}
```



#### Constant constructors（常量构造函数）

如果你的类提供一个状态不变的对象，你可以把这些对象 定义为编译时常量。<font color=#FF0000>要实现这个功能，需要定义一个 `const`构造函数， 并且声明所有类的变量为 `final`。</font>

```dart
class ImmutablePoint {
  final num x;
  final num y;
  const ImmutablePoint(this.x, this.y);
  static final ImmutablePoint origin = const ImmutablePoint(0, 0);
}
```



#### Factory constructors（工厂方法构造函数）

**如果一个构造函数并不总是返回一个新的对象，则使用 `factory`来定义 这个构造函数**。例如，<font color=#FF0000>一个工厂构造函数 可能从缓存中获取一个实例并返回，或者 返回一个子类型的实例。</font>

下面代码演示工厂构造函数 如何从缓存中返回对象。

```dart
class Logger {
  final String name;
  bool mute = false;

  // _cache is library-private, thanks to the _ in front
  // of its name.
  static final Map<String, Logger> _cache = <String, Logger>{};

  factory Logger(String name) {
    if (_cache.containsKey(name)) {
      return _cache[name];
    } else {
      final logger = new Logger._internal(name);
      _cache[name] = logger;
      return logger;
    }
  }

  Logger._internal(this.name);

  void log(String msg) {
    if (!mute) {
      print(msg);
    }
  }
}
```



> **注意：**工厂构造函数无法访问 `this`。

使用 `new`关键字来调用工厂构造函数。

```dart
void main() {
  var logger = new Logger('UI');
  logger.log('Button clicked');
}
```



### Methods（函数）

函数是类中定义的方法，是类对象的行为。

#### Instance methods（实例函数）

对象的实例函数可以访问 `this`。 例如下面示例中的 `distanceTo()`函数 就是实例函数：

```dart
import 'dart:math';

class Point {
  num x;
  num y;
  Point(this.x, this.y);
  
  num distanceTo(Point other) {
    var dx = x - other.x;
    var dy = y - other.y;
    return sqrt(dx * dx + dy * dy);
  }
}
```



#### Getters and setters

Getters 和 setters 是用来设置和访问对象属性的特殊 函数。<font color=#FF0000>每个实例变量都隐含的具有一个 getter， 如果变量不是 final 的则还有一个 setter</font>。 你可以通过实行 getter 和 setter 来创建新的属性， 使用 `get`和 `set`关键字定义 getter 和 setter：

```dart
import 'dart:math';

class Rectangle {
  num left;
  num top;
  num width;
  num height;

  Rectangle(this.left, this.top, this.width, this.height);

  num get right             => left + width;
      set right(num value)  => left = value - width;

   num get bottom           => top + height;
       set bottom(num value)=> top = value - height;
}

void main() {
  var rect = new Rectangle(3, 4, 20, 15);
  assert(rect.left == 3);
  rect.right = 12;
  assert(rect.left == -8);
}
```



<font color=#FF0000>getter 和 setter 的好处是，你可以开始使用实例变量，后来 你可以把实例变量用函数包裹起来，而调用你代码的地方不需要修改。</font>

> **注意：**<font color=#FF0000>像 (++) 这种操作符不管是否定义 getter 都会正确的执行。 为了避免其他副作用， 操作符只调用 getter 一次，然后 把其值保存到一个临时变量中。</font>



#### Abstract methods（抽象函数）

实例函数、 getter、和 setter 函数可以为抽象函数， **抽象函数是只定义函数接口但是没有实现的函数，由子类来 实现该函数**。<font color=#FF0000>如果用分号来替代函数体则这个函数就是抽象函数。</font>

```dart
abstract class Doer {
  // ...Define instance variables and methods...

  void doSomething(); // Define an abstract method.
}

class EffectiveDoer extends Doer {
  void doSomething() {
    // ...Provide an implementation, so the method is not abstract here...
  }
}
```

调用一个没实现的抽象函数会导致运行时异常。

另外参考 [抽象类](http://dart.goodev.org/guides/language/language-tour#abstract-classes)。



#### Overridable operators（可覆写的操作符）

下表中的操作符可以被覆写。 例如，如果你定义了一个 Vector 类， 你可以定义一个 `+`函数来实现两个向量相加。

| `<`  | `+`  | `|`  | `[]`  |
| ---- | ---- | ---- | ----- |
| `>`  | `/`  | `^`  | `[]=` |
| `<=` | `~/` | `&`  | `~`   |
| `>=` | `*`  | `<<` | `==`  |
| `–`  | `%`  | `>>` |       |

下面是覆写了 `+`和 `-`操作符的示例：

```dart
class Vector {
  final int x;
  final int y;
  const Vector(this.x, this.y);

  Vector operator +(Vector v) {
    return new Vector(x + v.x, y + v.y);
  }

  Vector operator -(Vector v) {
    return new Vector(x - v.x, y - v.y);
  }
}

void main() {
  final v = new Vector(2, 3);
  final w = new Vector(2, 2);

  assert(v.x == 2 && v.y == 3);

  assert((v + w).x == 4 && (v + w).y == 5);

  assert((v - w).x == 0 && (v - w).y == 1);
}
```



如果你覆写了 `==`，则还应该覆写对象的 `hashCode`getter 函数。 关于 覆写 `==`和 `hashCode`的示例请参考[实现 map 的 keys](http://dart.goodev.org/guides/libraries/library-tour#implementing-map-keys)。

关于覆写的更多信息请参考[扩展类](http://dart.goodev.org/guides/language/language-tour#extending-a-class)。



### Abstract classes（抽象类）

使用 `abstract`修饰符定义一个 *抽象类*—一个不能被实例化的类。 **抽象类通常用来定义接口， 以及部分实现**。<font color=#FF0000>如果你希望你的抽象类 是可示例化的，则定义一个[工厂 构造函数](http://dart.goodev.org/guides/language/language-tour#factory-constructors)。</font>



抽象类通常具有 [抽象函数](http://dart.goodev.org/guides/language/language-tour#abstract-methods)。 下面是**定义具有抽象函数的 抽象类的示例**：

```dart
// This class is declared abstract and thus
// can't be instantiated.
abstract class AbstractContainer {
  // ...Define constructors, fields, methods...

  void updateChildren(); // Abstract method.
}
```



下面的**类不是抽象的，但是定义了一个抽象函数，这样 的类是可以被实例化的**：

```dart
class SpecializedContainer extends AbstractContainer {
  // ...Define more constructors, fields, methods...

  void updateChildren() {
    // ...Implement updateChildren()...
  }

  // Abstract method causes a warning but
  // doesn't prevent instantiation.
  void doSomething();
}
```



### Implicit interfaces（隐式接口）

每个类都隐式的定义了一个包含所有实例成员的接口， 并且这个类实现了这个接口。<font color=#FF0000>如果你想 创建类 A 来支持 类 B 的 api，而不想继承 B 的实现， 则类 A 应该实现 B 的接口。</font>

一个类可以通过 `implements`关键字来实现一个或者多个接口， 并实现每个接口定义的 API。 例如：

```dart
class Person {
  final _name;

  Person(this._name);

  String greet(who) => 'Hello, $who. I am $_name';
}

class Imposter implements Person {
  final _name = "";

  String greet(who) => 'Hi $who. Do you know who I am?';
}
greetBob(Person person) => person.greet('bob');

void main() {
  print(greetBob(new Person('kathy')));
  print(greetBob(new Imposter()));
}

//output:
Hello, bob. I am kathy
Hi bob. Do you know who I am?
```



下面是实现多个接口 的示例：

```dart
class Point implements Comparable, Location {
  //...
}
```



### Extending a class（扩展类）

使用 `extends`定义子类， `supper`引用 超类：

```dart
class Television {
  void turnOn() {
    _illuminateDisplay();
    _activateIrSensor();
  }
  // ...
}

class SmartTelevision extends Television {
  void turnOn() {
    super.turnOn();
    _bootNetworkInterface();
    _initializeMemory();
    _upgradeApps();
  }
  // ...
}
```

<font color=#FF0000>子类可以覆写实例函数，getter 和 setter。</font> 下面是覆写 Object 类的 `noSuchMethod()`函数的例子， 如果调用了对象上不存在的函数，则就会触发 `noSuchMethod()`函 数。

```dart
class A {
  // Unless you override noSuchMethod, using a
  // non-existent member results in a NoSuchMethodError.
  void noSuchMethod(Invocation mirror) {
    print('You tried to use a non-existent member:' +
          '${mirror.memberName}');
  }
}
```

**还可以使用 `@override`注解来 表明你的函数是想覆写超类的一个函数**：

```dart
class A {
  @override
  void noSuchMethod(Invocation mirror) {
    // ...
  }
}
```

<font color=#FF0000>如果你使用 `noSuchMethod()`函数来实现每个可能的 getter 、setter、 以及其他类型的函数，你可以使用`@proxy`注解来避免警告信息</font>：

```dart
@proxy
class A {
  void noSuchMethod(Invocation mirror) {
    // ...
  }
}
```



如果你知道编译时的具体类型，则可以 实现这些类来避免警告，和 使用 `@proxy`效果一样：

```dart
class A implements SomeClass, SomeOtherClass {
  void noSuchMethod(Invocation mirror) {
    // ...
  }
}
```

关于注解的详情，请参考[Metadata](http://dart.goodev.org/guides/language/language-tour#metadata)。





### Enumerated types（枚举类型）

枚举类型通常称之为 *enumerations*或者 *enums*， 是一种特殊的类，用来表现一个固定 数目的常量。

#### Using enums

使用 `enum`关键字来定义枚举类型：

```dart
enum Color {
  red,
  green,
  blue
}
```

<font color=#FF0000></font>枚举类型中的每个值都有一个 `index`getter 函数， 该函数返回该值在枚举类型定义中的位置（从 0 开始）。 例如，第一个枚举值的位置为 0， 第二个为 1.





