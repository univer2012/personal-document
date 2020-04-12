# 笔记【latex03-LaTeX中的中文处理办法】



来自：[latex03-LaTeX中的中文处理办法](https://www.bilibili.com/video/BV1Vb411p7ko?p=3)

首先，操作：`选项(O)`-->`设置`，选择`构建`，在`默认编译器`中选择`XeLaTeX`；在`编译器`中的`默认字体编码`选择为`UTF-8`。



然后，在导言区，输入

```latex
\documentclass{article}

\usepackage{ctex}
```

来支持中文。



点击左下角栏目的“搜索”图标，输入`cmd`，打开终端窗口，输入`texdoc ctex`，打开ctex的文档。在文档中我们可以查看有关`ctex`的教程。



我们点击`使用CTeX文档类`，可以看到

> CTEX 宏集提供了四个中文文档类：ctexart、ctexrep、ctexbook 和 ctexbeamer，分别对应 LATEX 的标准文档类 article、report、book 和 beamer。使用它们的时候，需要将涉及到的所有 源文件使用 UTF-8 编码保存6。 



所以，我们可以使用如下命令来实现支持中文：

```latex
\documentclass{ctexart}
% ...
```



通过`texdoc`命令，可以帮助我们查看任何的由tex提供的帮助文件。比如输入`texdoc lshort-zh`，会打开latex的简单使用教程。



全部代码如下：

```latex
%%%来自：[](https://www.bilibili.com/video/BV1Vb411p7ko?p=2)

% 导言区
\documentclass{ctexart}% ctexbook, ctexrep

%\usepackage{ctex}

\newcommand\degree{^\circ}

\title{\heiti 杂谈勾股定理}
\author{\kaishu 张三}
\date{\today}

% 正文区（文稿区）
\begin{document}
	\maketitle
	
	勾股定理可以用现代语言标书如下：
	
	直角三角形斜边的平方等于两腰的平方和。
	
	可以用符号语言表述为：设直角三角形 $ABC$，其中 $\angle C=90\degree$，则有：
	\begin{equation}
		AB^2 = BC^2 + AC^2.
	\end{equation}
\end{document}
```

---

【完】