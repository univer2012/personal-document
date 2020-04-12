# 笔记：【P9_latex09_LaTeX中的浮动体

来自：[P9_latex09_LaTeX中的浮动体](https://www.bilibili.com/video/BV1Vb411p7ko?p=9)

```latex
% 导言区
\documentclass{ctexart}%ctexbook, ctexrep

%\usepackage{ctex}
\usepackage{graphicx}
\graphicspath{{figures/}} % 图片在当前目录下的figures 目录

% 正文区（文稿区）
\begin{document}
	\LaTeX{}中的插图：
	\includegraphics[scale=0.3]{lion}
	
	在\LaTeX{}中的表格：
	\begin{tabular}{l|c|c|c|r}
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



但是要灵活实现对图像和表格的管理，还需要使用浮动体环境。



在latex中，有figure浮动体环境，可以将`\includegraphics`代码放入figure浮动体环境中。

```latex
% 导言区
\documentclass{ctexart}%ctexbook, ctexrep

%\usepackage{ctex}
\usepackage{graphicx}
\graphicspath{{figures/}} % 图片在当前目录下的figures 目录

% 正文区（文稿区）
\begin{document}
	\LaTeX{}中的插图：
	\begin{figure}
		\includegraphics[scale=0.3]{lion}
	\end{figure}
	
	
	在\LaTeX{}中的表格：
	\begin{tabular}{l|c|c|c|r}
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



还有table浮动体环境，可以将用于生成表格的tabular放在table环境中，

```latex
% 导言区
\documentclass{ctexart}%ctexbook, ctexrep

%\usepackage{ctex}
\usepackage{graphicx}
\graphicspath{{figures/}} % 图片在当前目录下的figures 目录

% 正文区（文稿区）
\begin{document}
	\LaTeX{}中的插图：
	\begin{figure}
		\includegraphics[scale=0.3]{lion}
	\end{figure}
	
	
	在\LaTeX{}中的表格：
	\begin{table}
		\begin{tabular}{l|c|c|c|r}
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
	\end{table}
	
\end{document}
```

编译，可以看到图像与表格的位置，都发生了浮动，



当然也可以采用`\centering`命令，让浮动中的内容居中排版，

```latex
% 导言区
\documentclass{ctexart}%ctexbook, ctexrep

%\usepackage{ctex}
\usepackage{graphicx}
\graphicspath{{figures/}} % 图片在当前目录下的figures 目录

% 正文区（文稿区）
\begin{document}
	\LaTeX{}中的插图：
	\begin{figure}
		\centering
		\includegraphics[scale=0.3]{lion}
	\end{figure}
	
	
	在\LaTeX{}中的表格：
	\begin{table}
		\centering
		\begin{tabular}{l|c|c|c|r}
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
	\end{table}
	
\end{document}
```



由于`\centering`命令是在figure和table环境中，所以它只影响环境中的内容。还可以通过可选参数指定浮动体的排版位置，并通过`\caption`命令设置插图的标题。

```latex
% 导言区
\documentclass{ctexart}%ctexbook, ctexrep

%\usepackage{ctex}
\usepackage{graphicx}
\graphicspath{{figures/}} % 图片在当前目录下的figures 目录

% 正文区（文稿区）
\begin{document}
	\LaTeX{}中的插图：
	\begin{figure}[htbp]
		\centering
		\includegraphics[scale=0.3]{lion}
		\caption{\TeX 系统的吉祥物---小狮子}
	\end{figure}
	
	
	在\LaTeX{}中的表格：
	\begin{table}
		\centering
		\begin{tabular}{l|c|c|c|r}
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
	\end{table}
	
\end{document}
```

![](\Users\Acer\Documents\LaTex\read_me\md_pictures\latex09_01.bmp)

由排版结果可以看到，该插图被自动进行了编号。



对于table环境，我们也可以做类似的处理。

```latex
在\LaTeX{}中的表格：
	\begin{table}
		\centering
		\caption{考试成绩单}
		\begin{tabular}{l|c|c|c|r}
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
	\end{table}
	%...
```



可以看到，表格也被自动进行了编号。并且与插图的编号是相互独立的。



同样可以设置table环境的排版位置参数。



同时还可以使用label命令，为浮动体设置标签，利用`\ref`命令可以使用这个标签，从而实现交叉引用：

```latex
\LaTeX{}中\TeX 系统的吉祥物---小狮子见图\ref{fig-lion}：
	\begin{figure}[htbp]
		\centering
		\includegraphics[scale=0.3]{lion.png}
		\caption{\TeX 系统的吉祥物---小狮子}\label{fig-lion}
	\end{figure}
	%...
```

![](\Users\Acer\Documents\LaTex\read_me\md_pictures\latex09_02.bmp)

这是交叉引用的结果。



当然也可以设置表格浮动体的标签，然后通过这个标签，使用ref命令引用这个表格。从而实现表格的交叉引用。

```latex
%...
当然，在\LaTeX{}中也可以使用表\ref{tab-score}所示的表格。
	\begin{table}[h]
		\centering
		\caption{考试成绩单}\label{tab-score}
		\begin{tabular}{l|c|c|c|r}
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
	\end{table}
	%...
```





```latex
%%%  P9_latex09_LaTeX中的浮动体
% 导言区
\documentclass{ctexart}%ctexbook, ctexrep

%\usepackage{ctex}
%\usepackage{graphics}
\usepackage{graphicx}
\graphicspath{{pictures/}} % 图片在当前目录下的figures 目录

% 正文区（文稿区）
\begin{document}
	\LaTeX{}中\TeX 系统的吉祥物---小狮子见图\ref{fig-lion}：
	\begin{figure}[htbp]
		\centering
		\includegraphics[scale=0.3]{lion.png}
		\caption{\TeX 系统的吉祥物---小狮子}\label{fig-lion}
	\end{figure}
	
	遥望太白，看积雪皑皑，别有一番风景(图\ref{fig-mountain})。
	\begin{figure}[htbp]
		\centering
		\includegraphics[scale=0.3]{mountain.jpg}
		\caption{太白山}\label{fig-mountain}
	\end{figure}

	熟练使用\LaTeX 中的TiKz，可以绘制如图\ref{fig-tikz}所示的精美矢量图。
	\begin{figure}[htbp]
		\centering
		\includegraphics[scale=0.3]{oscilloscope}
		\caption{\LaTeX 中的矢量图}\label{fig-tikz}
	\end{figure}
	
	当然，在\LaTeX{}中也可以使用表\ref{tab-score}所示的表格。
	\begin{table}[h]
		\centering
		\caption{考试成绩单}\label{tab-score}
		\begin{tabular}{l|c|c|c|r}
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
	\end{table}
	
\end{document}
```

由结果可以看出，所有的插图都进行了编号，并且实现了正确的交叉引用。可以在源代码中适当插图空行，使得源代码更加清晰。



当然，如果不需要某一部分内容时，我们可以将这一部分内容进行注释。快捷键：Ctrl+T。

```latex
%...
\LaTeX{}中\TeX 系统的吉祥物---小狮子见图\ref{fig-lion}：
	\begin{figure}[htbp]
		\centering
		\includegraphics[scale=0.3]{lion.png}
		\caption{\TeX 系统的吉祥物---小狮子}\label{fig-lion}
	\end{figure}
	
%	遥望太白，看积雪皑皑，别有一番风景(图\ref{fig-mountain})。
%	\begin{figure}[htbp]
%		\centering
%		\includegraphics[scale=0.3]{mountain.jpg}
%		\caption{太白山}\label{fig-mountain}
%	\end{figure}

	熟练使用\LaTeX 中的TiKz，可以绘制如图\ref{fig-tikz}所示的精美矢量图。
	\begin{figure}[htbp]
		\centering
		\includegraphics[scale=0.3]{oscilloscope}
		\caption{\LaTeX 中的矢量图}\label{fig-tikz}
	\end{figure}
	%...
```

从排版结果可以看出，剩余的插图都进行了正确的编号。和正确的交叉引用。如果需要找回原来的内容，只需要去掉注释即可。



浮动体

* 实现灵活分页（避免无法分割的内容产生的页面留白）
* 给图表添加标题
* 交叉引用



figure环境(table环境与之类似)

\begin{figure}[<允许位置>]:

​	<任意内容>

\end{figure}



<允许位置>参数(默认tbp)

* h，此处（here）-代码所在的上下文位置
* t，页顶（top）-代码所在页面或之后页面的顶部
* b，页底（bottom）-代码所在页面或之后页面的底部
* p，独立一页（page）-浮动页面



标题控制(caption、bicaption等宏包)

并排与子图表(subcaption、subfig、floatrow等宏包)

绕排(picinpar、wrapfig等宏包)