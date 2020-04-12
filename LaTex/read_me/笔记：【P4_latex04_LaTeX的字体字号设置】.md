# 笔记：【[P4_latex04_LaTeX的字体字号设置】

来自：[P4_latex04_LaTeX的字体字号设置](https://www.bilibili.com/video/BV1Vb411p7ko?p=4)



### 1.字体组设置（罗马字体、无衬线字体、打字机字体）

字体命令：

```latex
	%设置罗马字体
	\textrm{Roman Family}
	
	%无衬线字体
	\textsf{Sans Serif Family}
	
	%打字机字体
	\texttt{Typewriter Family}
```



字体声明：

```latex
%设置罗马字体
\rmfamily Roman Family

%无衬线字体
\sffamily Sans Serif Family

%打字机字体
\ttfamily Typewriter Family
```



既可以使用字体命令，作用于命令的参数，也可以使用字体声明，作用于后续的文本。也可以用大括号，对文本进行分组，从而限定字体声明的作用范围。



例如，

```latex
	\sffamily who you are? you find self on everyone around.
	take you as the same as others!
	
	Are you wiser than others? definitely no. in some ways, may it is true. What can you achieve? a luxurious house? a brillilant car? an admirable career? who knows?
```

则后续所有字体将使用`无衬线字体`。请注意查看结果。



当遇到另一个字体声明时，会结束当前字体声明，而启用新的字体声明。

```latex
\sffamily who you are? you find self on everyone around.
	take you as the same as others!
	
	\ttfamily Are you wiser than others? definitely no. in some ways, may it is true. What can you achieve? a luxurious house? a brillilant car? an admirable career? who knows?
```



当然同样可以使用大括号进行分组，以限定声明作用的范围。

```latex
{\sffamily who you are? you find self on everyone around.
	take you as the same as others!}
	
	{\ttfamily Are you wiser than others? definitely no. in some ways, may it is true. What can you achieve? a luxurious house? a brillilant car? an admirable career? who knows?}
```

### 2.字体系列设置（粗细、宽度）

```latex
% 字体系列设置（粗细、宽度）
	\textmd{Medium Series} \textbf{Boldface Series}
	
	{\mdseries Medium Series} {\bfseries Boldface Series}
```



### 3.字体形状（直立、斜体、伪斜体、小型大写）

```latex
% 字体形状（直立、斜体、伪斜体、小型大写）
	\textup{Upright Shape} \textit{Italic Shape}
	
	\textsl{Slanted Shape} \textsc{Small Caps Shape}
	
	{\upshape Upright Shape} {\itshape Italic Shape} 
	{\slshape Slanted Shape} {\scshape Small Caps Shape}
```



### 4.中文字体

注意：需使用ctex宏包，否则无法使用中文字体设置

```latex
	% 中文字体（注意：需使用ctex宏包，否则无法使用中文字体设置）
	{\songti 宋体} \quad {\heiti 黑体} \quad {\fangsong 仿宋} \quad {\kaishu 楷书}
```



中文字体的形状：

```latex
中文字体的\textbf{粗体}与\textit{斜体}
```





全部代码如下：

```latex
%%%来自：[P4_latex04_LaTeX的字体字号设置](https://www.bilibili.com/video/BV1Vb411p7ko?p=4)

% 导言区
\documentclass{article}

\usepackage{ctex}




% 正文区（文稿区）
\begin{document}
	% 字体组设置（罗马字体、无衬线字体、打字机字体）
	%设置罗马字体
	\textrm{Roman Family} 	%字体命令，作用于命令的参数
	%或者
	\rmfamily Roman Family	%字体声明
	
	%无衬线字体
	\textsf{Sans Serif Family}
	%或者
	\sffamily Sans Serif Family
	
	%打字机字体
	\texttt{Typewriter Family}
	%或者
	\ttfamily Typewriter Family
	
	
	{\sffamily who you are? you find self on everyone around.
	take you as the same as others!}
	
	{\ttfamily Are you wiser than others? definitely no. in some ways, may it is true. What can you achieve? a luxurious house? a brillilant car? an admirable career? who knows?}
	
	
	% 字体系列设置（粗细、宽度）
	\textmd{Medium Series} \textbf{Boldface Series}
	
	{\mdseries Medium Series} {\bfseries Boldface Series}
	
	% 字体形状（直立、斜体、伪斜体、小型大写）
	\textup{Upright Shape} \textit{Italic Shape}
	
	\textsl{Slanted Shape} \textsc{Small Caps Shape}
	
	{\upshape Upright Shape} {\itshape Italic Shape} 
	
	{\slshape Slanted Shape} {\scshape Small Caps Shape}
	
	% 中文字体（注意：需使用ctex宏包，否则无法使用中文字体设置）
	{\songti 宋体} \quad {\heiti 黑体} \quad {\fangsong 仿宋} \quad {\kaishu 楷书}
	
	中文字体的\textbf{粗体}与\textit{斜体}
	
	
	% 字体大小
	{\tiny				Hello}\\
	{\scriptsize		Hello}\\
	{\footnotesize		Hello}\\
	{\small				Hello}\\
	{\normalsize		Hello}\\
	{\large				Hello}\\
	{\Large				Hello}\\
	{\LARGE				Hello}\\
	{\huge				Hello}\\
	{\Huge				Hello}\\
	
	% 中文字号设置命令
	\zihao{-0}你好！
	
	\zihao{5}你好！
	
\end{document}
```

