# 笔记：【P8_latex08_LaTeX中的表格

来自：[P8_latex08_LaTeX中的表格](https://www.bilibili.com/video/BV1Vb411p7ko?p=8)

使用tabular环境生成表格，tabular环境需要一个指定列排版格式的必选参数，用l指定左对齐，用c指定居中对齐，用r指定右对齐。下面的例子中生成了一个5列的表格，分别是左对齐、居中对齐、居中对齐、居中对齐、右对齐，



不同列之间用&符号分割。用`\\`结束本行，并产生新的一行。

```latex
% 导言区

\documentclass{ctexart} %ctexbook, ctexrep

%\usepackage{ctex}

% 正文区（文稿区）
\begin{document}
	\begin{tabular}{l c c c r}
		姓名 & 语文 & 数学 & 外语 & 备注 \\
		张三 & 87 & 100 & 93 & 优秀 \\
		李四 & 75 & 64 & 52 & 补考另行通知 \\
		王二 & 80 & 82 & 78 & \\
	\end{tabular}
\end{document}
```



可以用`|`符号产生表格竖线。可以使用`\hline`命令产生表格横线。也可以双`\hline`命令产生双横线。可以用2个`||`表格，产生双竖线。

```latex
% 导言区

\documentclass{ctexart} %ctexbook, ctexrep

%\usepackage{ctex}

% 正文区（文稿区）
\begin{document}
	\begin{tabular}{l||c|c|c|r}
		\hline
		姓名 & 语文 & 数学 & 外语 & 备注 \\
		\hline \hline
		张三 & 87 & 100 & 93 & 优秀 \\
		\hline
		李四 & 75 & 64 & 52 & 补考另行通知 \\
		\hline
		王二 & 80 & 82 & 78 & \\
		\hline
	\end{tabular}
\end{document}
```



可以在任何需要的地方添加表格线。

```latex
% 导言区

\documentclass{ctexart} %ctexbook, ctexrep

%\usepackage{ctex}

% 正文区（文稿区）
\begin{document}
	\begin{tabular}{|l||c|c|c|r|}
		\hline
		姓名 & 语文 & 数学 & 外语 & 备注 \\
		\hline \hline
		张三 & 87 & 100 & 93 & 优秀 \\
		\hline
		李四 & 75 & 64 & 52 & 补考另行通知 \\
		\hline
		王二 & 80 & 82 & 78 & \\
		\hline
	\end{tabular}
\end{document}
```



在列格式声明中，可以用p产生指定宽度的表列，列宽度由p参数指定。由p指定的列格式，当内容超过宽度时，会自动产生换行。

```latex
% 导言区

\documentclass{ctexart} %ctexbook, ctexrep

%\usepackage{ctex}

% 正文区（文稿区）
\begin{document}
	\begin{tabular}{|l|c|c|c|p{1.5cm}|}
		\hline
		姓名 & 语文 & 数学 & 外语 & 备注 \\
		\hline \hline
		张三 & 87 & 100 & 93 & 优秀 \\
		\hline
		李四 & 75 & 64 & 52 & 补考另行通知 \\
		\hline
		王二 & 80 & 82 & 78 & \\
		\hline
	\end{tabular}
\end{document}
```



可以在终端，输入`texdoc booktab`打开相应的说明文件，



`texdoc booktab`   三线表

`texdoc longtable`  跨越长表格

`texdoc tabu`  综合表格宏包



