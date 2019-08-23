# Dart 语法预览


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

