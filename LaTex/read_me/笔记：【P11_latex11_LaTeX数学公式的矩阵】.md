# 笔记【P11_latex11_LaTeX数学公式的矩阵】

来自：[P11_latex11_LaTeX数学公式的矩阵](https://www.bilibili.com/video/BV15x411j7k6?p=11)



使用`matrix`进行排版。用于矩阵排版的matrix环境，与用于表格排版的tabular环境，使用方法非常类似。需要使用`\usepackage`引入`amsmath`宏包。



注意调整matrix源代码的格式，以便后期维护，类似的，也可以使用其他的矩阵排版环境。例如，pmatrix，用于在矩阵两端加小括号。小写的bmatrix，用于加中括号。大写的Bmatrix，用于加大括号。小写的vmatrix，用于加单竖线。大写的Vmatrix，用于加双竖线。



与tabular环境类似，在matrix环境中，也是用&符号分隔列，用`\\`命令分割行。在矩阵中，也可以使用下划线(`_`)和帽子符号(`^`)来标识上下标，注意查看结果。



矩阵中经常使用的省略号，可以用`\dots`、`\vdots`、`\ddots`来实现。注意查看结果。

```latex
% 常用省略号：
	\[
	A = \begin{bmatrix}
	a_{11} & \dots & a_{1n} \\
	& \ddots & \vdots \\
	0 & & a_{nn}
	\end{bmatrix}_{n \times n}
	\]
```



在数学模式中，可以用`\times`命令来排版乘号。那么，能不能用一个类似的`\adots`命令，来输入另一个方向上的省略号呢？没有`\adots`命令。当然，我们可以使用`\newcommand`命令来实现一个`\adots`命令：

```latex
\newcommand{\adots}{\mathinner{\mkern2mu%
		\raisebox{0.1em}{.}\mkern2mu\raisebox{0.4em}{.}%
		\mkern2mu\raisebox{0.7em}{.}\mkern1mu}}
```



也就是用不同的方式，来排版3个英文句点符号。细节请大家查阅相关资料。注意查看结果：

```latex
	% 常用省略号：
	\[
	A = \begin{bmatrix}
	a_{11} & \dots & a_{1n} \\
	\adots & \ddots & \vdots \\
	0 & & a_{nn}
	\end{bmatrix}_{n \times n}
	\]
```



当然，利用矩阵函数的嵌套，还可以实现分块矩阵的排版。也就是把一个矩阵，作为另一个矩阵的一个元素进行处理。此处的`\text`命令用于在数学模式中，临时切换到文本模式。注意查看结果：

```latex
	% 分块矩阵(矩阵嵌套)
	\[
	\begin{pmatrix}
	\begin{matrix} 1&0\\0&1 \end{matrix}
	& \text{\Large 0} \\
	\text{\Large 0} & \begin{matrix}
	1&0\\0&-1 \end{matrix}
	\end{pmatrix}
	\]
```

如果在数学模式中，不使用`\text`命令，则结果是不一样的。



利用matrix环境，还可以排版三角矩阵。可以使用`\muticolumn`命令合并多列，也可以用`\raisebox`命令来调整高度。





还可以使用`\hdotsfor`产生跨列省略号，

```latex
	% 跨列的省略号：\hdotsfor{<列数>}
	\[
	\begin{pmatrix}
	1 & \frac 12 & \dots & \frac 1n \\
	\hdotsfor{4} \\
	m & \frac m2 & \dots & \frac mn
	\end{pmatrix}
	\]
```



同时还可以使用`\smallmatrix`环境，排版行内小矩阵。

```latex
% 行内小矩阵(smallmatrix)环境
	复数$z = (x,y)$ 也可用矩阵
	\begin{math}
		\left(  % 需要手动加上左括号
		\begin{smallmatrix}
		x & -y \\ y & x
		\end{smallmatrix} % 需要手动加上右括号
		\right)
	\end{math}来表示。
```

例如，将`smallmatrix`置于`math`环境中，此处的`\left(` 命令，用于生成矩阵的左括号，`smallmatrix`命令与`matrix` 环境的使用方式，完全相同，可以用&符号分割各列，用`\\`符号实现换行。用`\right)`命令产生矩阵右括号。需要注意的是`\left(`  和 `\right)` 命令是成对出现、相互呼应的。



也可以使用array环境排版矩阵。array环境与表格环境tabular一致。在必选参数中利用`r`、l、c和竖线指定列位置格式。仍然使用&符号分割各列，用`\\`命令换行，利用`\hline`命令产生横线。在本例中，需要注意分式排版命令的特殊使用方式，也就是可以不使用分组命令排版分式，当然也可以使用大括号分组，以区分分子和分母。注意，当不使用分组时，`\frac`命令只能区分单个字母，注意`\frac abc`中的`c`并不属于分式的一部分。如果`\frac`后面直接跟字母会产生语法错误。

```latex
	% array环境（类似于表格环境tabular）
	\[
	\begin{array}{r|r}
	\frac12 & 0 \\
	\hline
	0 & -\frac abc \\
	\end{array}
	\]
```



利用array环境，可以排版更为复杂的矩阵，先查看结果，该array环境，用`c`指定第一列居中对齐，用`l`指定最后一列居左对齐。利用`@`符号，使用`hspace`命令，在2列之间插入一个-5pt的水平空白。注意，用`@`符号插入的内容，不列入表列计数。



可以使用`\underbrace`产生横向大括号，用`\rule`命令指定横向大括号的尺寸。以下标的方式指定m标志符。

```latex
	% 用array环境构造复杂矩阵
	\[
	% @{<内容>}-添加任意内容，不占表项计数
	% 此处添加一个负值空白，表示向左移-5pt的距离
	\begin{array}{c@{\hspace{-5pt}}l}
	% 第1行，第1列
	\left(
	\begin{array}{ccc|ccc}
	a & \cdots & a & b & \cdots & b \\
	& \ddots & \vdots & \vdots & adots \\
	&		 & a & b \\ \hline
	&		 &	 & c & \cdots & c \\
	&		 &	 & \vdots &  & \vdots \\
	\multicolumn{3}{c|}{\raisebox{2ex}[0pt]{\Huge 0}}
	& c & \cdots & c
	\end{array}
	\right)
	& % 第1行第2列
	\begin{array}{l}
	% left.仅表示与$\right$\}配对，什么都不输出
	\left. \rule{0mm}{7mm}\right\}p\\
	\\
	\left.\rule{0mm}{7mm}\right\}q
	\end{array}
	\\[-5pt]
	% 第2行第1列
	\begin{array}{cc}
	\underbrace{\rule{17mm}{0mm}}_m &
	\underbrace{\rule{17mm}{0mm}}_n 
	\end{array}	
	& 
	% 第2行第2列
	\end{array}
	\]
```





全部代码如下：

```latex
%%%  P11_latex11_LaTeX数学公式的矩阵
% 导言区
\documentclass{ctexart}%ctexbook, ctexrep

%\usepackage{ctex}
\usepackage{amsmath}

\newcommand{\adots}{\mathinner{\mkern2mu%
		\raisebox{0.1em}{.}\mkern2mu\raisebox{0.4em}{.}%
		\mkern2mu\raisebox{0.7em}{.}\mkern1mu}}


% 正文区（文稿区）
\begin{document}
	% 矩阵环境，用&分隔列，用\\分隔行 
	\[
	\begin{matrix}
		0 & 1 \\
		1 & 0
	\end{matrix} \qquad
	%pmatrix环境
	\begin{pmatrix}
	0 & -i \\
	i & 0
	\end{pmatrix} \qquad
	%bmatrix环境
	\begin{bmatrix}
	0 & -1 \\
	1 & 0
	\end{bmatrix} \qquad
	% Bmatrix环境
	\begin{Bmatrix}
	1 & 0 \\
	0 & -1
	\end{Bmatrix} \qquad
	% vmatrix环境
	\begin{vmatrix}
	a & b \\
	c & d
	\end{vmatrix} \qquad
	% Vmatrix环境
	\begin{Vmatrix}
	i & 0 \\
	0 & -i
	\end{Vmatrix} 
	\]
	
	% 可以使用上下标
	\[
	A = \begin{pmatrix}
	a_{11}^2 & a_{12}^2 & a_{13}^2 \\
	0 & a_{22} & a_{23} \\
	0 & 0 & a_{33}
	\end{pmatrix}
	\]
	
	% 常用省略号：
	\[
	A = \begin{bmatrix}
	a_{11} & \dots & a_{1n} \\
	\adots & \ddots & \vdots \\
	0 & & a_{nn}
	\end{bmatrix}_{n \times n}
	\]
	
	% 分块矩阵(矩阵嵌套)
	\[
	\begin{pmatrix}
	\begin{matrix} 1&0\\0&1 \end{matrix}
	& \text{\Large 0} \\
	\text{\Large 0} & \begin{matrix}
	1&0\\0&-1 \end{matrix}
	\end{pmatrix}
	\]
	
	% 三角矩阵
	\[
	\begin{pmatrix}
	a_{11} & a_{12} & \cdots & a_{1n} \\
	& a_{22} & \cdots & a_{2n} \\
	&		 & \ddots & \vdots \\
	\multicolumn{2}{c}{\raisebox{1.3ex}[0pt]{\Huge 0}}
	&		 &a_{nn}
	\end{pmatrix}
	\]
	
	% 跨列的省略号：\hdotsfor{<列数>}
	\[
	\begin{pmatrix}
	1 & \frac 12 & \dots & \frac 1n \\
	\hdotsfor{4} \\
	m & \frac m2 & \dots & \frac mn
	\end{pmatrix}
	\]
	
	% 行内小矩阵(smallmatrix)环境
	复数$z = (x,y)$ 也可用矩阵
	\begin{math}
		\left(  % 需要手动加上左括号
		\begin{smallmatrix}
		x & -y \\ y & x
		\end{smallmatrix} % 需要手动加上右括号
		\right)
	\end{math}来表示。
	
	
	% array环境（类似于表格环境tabular）
	\[
	\begin{array}{r|r}
	\frac12 & 0 \\
	\hline
	0 & -\frac abc \\
	\end{array}
	\]
	
	
	
	
	% 用array环境构造复杂矩阵
	\[
	% @{<内容>}-添加任意内容，不占表项计数
	% 此处添加一个负值空白，表示向左移-5pt的距离
	\begin{array}{c@{\hspace{-5pt}}l}
	% 第1行，第1列
	\left(
	\begin{array}{ccc|ccc}
	a & \cdots & a & b & \cdots & b \\
	& \ddots & \vdots & \vdots & adots \\
	&		 & a & b \\ \hline
	&		 &	 & c & \cdots & c \\
	&		 &	 & \vdots &  & \vdots \\
	\multicolumn{3}{c|}{\raisebox{2ex}[0pt]{\Huge 0}}
	& c & \cdots & c
	\end{array}
	\right)
	& % 第1行第2列
	\begin{array}{l}
	% left.仅表示与$\right$\}配对，什么都不输出
	\left. \rule{0mm}{7mm}\right\}p\\
	\\
	\left.\rule{0mm}{7mm}\right\}q
	\end{array}
	\\[-5pt]
	% 第2行第1列
	\begin{array}{cc}
	\underbrace{\rule{17mm}{0mm}}_m &
	\underbrace{\rule{17mm}{0mm}}_n 
	\end{array}	
	& 
	% 第2行第2列
	\end{array}
	\]
\end{document}
```

