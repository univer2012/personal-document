# 笔记【P12_latex12_LaTeX数学公式的多行公式】

来自：P12_latex12_LaTeX数学公式的多行公式](https://www.bilibili.com/video/BV15x411j7k6?p=12)



引入`amsmath`、`amssymb`宏包，

可以使用`gather`环境实现多行公式的排版。在`gather`环境中，可以使用`\\`命令，实现换行。注意查看结果，不但实现了多行公式的排版，对每行公式都进行了编号。

```latex
% gather 和 gather* 环境（可以使用\\换行）
	% 带编号
	\begin{gather}
		a + b = b + a \\
		ab ba
	\end{gather}
```



也可使使用带`*`号命令实现不带编号的公式排版

```latex
	% 不带编号
	\begin{gather*}
	3+5 = 5+3 = 8 \\
	3 \times 5 = 5 \times 3
	\end{gather*}
```



在`gather`环境中，也可以在`\\`命令前，使用`\notag`命令阻止编号。可以看到有`\notag`命令的这一行公式，并没有进行编号。而其他的公式进行了编号。

```latex
	% 在\\前使用\notag 阻止编号
	\begin{gather}
	3^2 + 4^2 = 5^2 \notag \\
	5^2 + 12^2 + 13^2 \notag \\
	a^2 + b^2 = c^2
	\end{gather}
```



也可使用align环境和`align*`环境，在公式排版中，按指定位置进行对齐，同样，`align`环境用于实现公式的编号，而`align*`环境对公式不进行编号。对齐位置是由`&`符号指定的。

例如，第1个是按等号左端对齐。也可以指定任意位置实现对齐，例如可以按等号对齐，按部分公式的开始位置对齐。

```latex
% align 和 align* 环境（用 & 进行对齐）
	% 带编号
	\begin{align}
		x &= t + \cos t +1 \\
		y &= 2\sin t
	\end{align}
	% 不带编号
	\begin{align*}
		x &= t & x &= \cos t & x &= t \\
		y &= 2t & y &= \sin(t+1)  & y &= \sin t
	\end{align*}
```





也可以使用`split`环境，在`equation`环境中，实现一个公式的多行排版，其对齐方式仍然由`&`符号指定。分行仍然用`\\`命令实现。

```latex
	% split 环境（对齐采用 align 环境的方式，编号在中间）
	\begin{equation}
		\begin{split}
		\cos 2x &= \cos^2 x - \sin^2 x \\
		&= 2\cos^2 x - 1
		\end{split}
	\end{equation}
```



注意，这是由`equation`环境排版的一个公式，所以只有一个编号并且在公式方向垂直居中排版。



对于类似分段函数的公式排版，可以使用`cases`环境实现，在`cases`环境中，可以使用`&`符号将一个公式分成两部分。并再次对齐。同样使用双反斜杠命令实现换行。

```latex
% cases 环境
	% 每行公式中使用 & 分隔为两部分，
	% 通常表示值和后面 的条件
	\begin{equation}
		D(x) = \begin{cases}
		1,& \text{如果 } x \in \mathbb{Q}; \\
		0,& \text{如果 } x \in \mathbb{R}\setminus\mathbb{Q};
		\end{cases}
	\end{equation}
```

注意此时是按照一个公式进行编号。`\mathbb{}`命令用于输出花体字符，这需要`amssymb`宏包的支持。数学模式中的`\text{}`命令用于临时切换到文本模式。如果不使用`\text{}`命令，则在数学模式中无法使用中文排版。因此需要使用`\text`命令在数学模式中处理中文。



多行公式要使用`amsmath`和`amssymb`宏包。



全部代码如下：

```latex
%%%  P11_latex12_LaTeX数学公式的多行公式
% 导言区
\documentclass{ctexart}%ctexbook, ctexrep

%\usepackage{ctex}
\usepackage{amsmath}
\usepackage{amssymb}

% 正文区（文稿区）
\begin{document}
	% gather 和 gather* 环境（可以使用\\换行）
	% 带编号
	\begin{gather}
		a + b = b + a \\
		ab ba
	\end{gather}
	
	% 不带编号
	\begin{gather*}
	3+5 = 5+3 = 8 \\
	3 \times 5 = 5 \times 3
	\end{gather*}
	
	% 在\\前使用\notag 阻止编号
	\begin{gather}
	3^2 + 4^2 = 5^2 \notag \\
	5^2 + 12^2 + 13^2 \notag \\
	a^2 + b^2 = c^2
	\end{gather}
	
	% align 和 align* 环境（用 & 进行对齐）
	% 带编号
	\begin{align}
		x &= t + \cos t +1 \\
		y &= 2\sin t
	\end{align}
	% 不带编号
	\begin{align*}
		x &= t & x &= \cos t & x &= t \\
		y &= 2t & y &= \sin(t+1)  & y &= \sin t
	\end{align*}
	
	% split 环境（对齐采用 align 环境的方式，编号在中间）
	\begin{equation}
		\begin{split}
		\cos 2x &= \cos^2 x - \sin^2 x \\
		&= 2\cos^2 x - 1
		\end{split}
	\end{equation}
	
	% cases 环境
	% 每行公式中使用 & 分隔为两部分，
	% 通常表示值和后面 的条件
	\begin{equation}
		D(x) = \begin{cases}
		1,& \text{如果 } x \in \mathbb{Q}; \\
		0,& \text{如果 } x \in \mathbb{R}\setminus\mathbb{Q};
		\end{cases}
	\end{equation}
	
\end{document}
```



---

【完】