# 笔记：【P5_latex05_LaTe文档的基本结构】

来自：[P5_latex05_LaTe文档的基本结构](https://www.bilibili.com/video/BV1Vb411p7ko?p=5)



大体的latex结构如下：

```latex
\documentclass{article}

\usepackage{ctex}

\begin{document}
	\section{引言}
	\section{实验方法}
	\section{实验结果}
	\subsection{数据}
	\subsection{图表}
	\subsubsection{实验条件}
	\subsubsection{实验过程}
	\subsection{结果分析}
	\section{结论}
	\section{致谢}
\end{document}
```



接下来插入引言：

```latex
\documentclass{article}

\usepackage{ctex}





\begin{document}
	\section{引言}
	近年来，随着逆向工程和三维重建技术的发展和应用，获取现实世界中物体的三维数据的方法越来越多的关注和研究，很多研究机构和商业公司都陆续推出了自己的三维重建系统。
	
	近年来，随着逆向工程和三维重建技术的发展和应用，获取现实世界中物体的三维数据的方法越来越多的关注和研究，很多研究机构和商业公司都陆续推出了自己的三维重建系统。
	\section{实验方法}
	\section{实验结果}
	\subsection{数据}
	\subsection{图表}
	\subsubsection{实验条件}
	\subsubsection{实验过程}
	\subsection{结果分析}
	\section{结论}
	\section{致谢}
\end{document}
```

效果如下：

![](C:\Users\Acer\Documents\LaTex\read_me\md_pictures\latex05_01.png)

可以看到，空行用于分割段落，形成一个新的段落。注意，一个空行和多个空行的效果是一样的。



我们也可以通过反斜杠命令`\\`实现换行：

```latex
%...
\section{引言}
	近年来，随着逆向工程和三维重建技术的发展和应用，获取现实世界中物体的三维数据的方法越来越多的关注和研究，很多研究机构和商业公司都陆续推出了自己的三维重建系统。
	
	近年来，随着逆向工程和三维重建技术的发展和应用，获取现实世界中物体的三维数据的方法越来越多的关注和研究。\\很多研究机构和商业公司都陆续推出了自己的三维重建系统。
	%...
```

也可以使用paragraph命令，来产生新的段落。

```latex
%...
\section{引言}
	近年来，随着逆向工程和三维重建技术的发展和应用，获取现实世界中物体的三维数据的方法越来越多的关注和研究，很多研究机构和商业公司都陆续推出了自己的三维重建系统。
	
	近年来，随着逆向工程和三维重建技术的发展和应用，获取现实世界中物体的三维数据的方法越来越多的关注和研究。\par 很多研究机构和商业公司都陆续推出了自己的三维重建系统。
	\section{实验方法}
	%...
```



通常，为了保证原文段的清晰，分段通常采用空行来实现。



当然，也可以使用`ctexart`来实现这一的操作：

```latex
\documentclass{ctexart}
```

大家注意，此时`section`的标题是居中排版的，当然，这些设置是可以更改的。在此，我们使用`ctex`命令进行更改。我们使用如下命令来更改：

```latex
\documentclass{ctexart}

%\usepackage{ctex}

\ctexset {
	section = {
		format+ = \zihao{-4} \heiti \raggedright,
		name = {,、},
		number = \chinese{section},
		beforeskip = 1.0ex plus 0.2ex minus .2ex,
		afterskip = 1.0ex plus 0.2ex minus .2ex,
		aftername = \hspace{0pt}
	},
	subsection = {
		format+ = \zihao{5} \heiti \raggedright,
		% name={\thesubsection、},
		name = {,、},
		number = \arabic{subsection},
		beforeskip = 1.0ex plus 0.2ex minus .2ex,
		afterskip = 1.0ex plus 0.2ex minus .2ex,
		aftername = \hspace{0pt}
	}
}

\begin{document}
	\section{引言}
	近年来，随着逆向工程和三维重建技术的发展和应用，获取现实世界中物体的三维数据的方法越来越多的关注和研究，很多研究机构和商业公司都陆续推出了自己的三维重建系统。
	
	近年来，随着逆向工程和三维重建技术的发展和应用，获取现实世界中物体的三维数据的方法越来越多的关注和研究。\par 很多研究机构和商业公司都陆续推出了自己的三维重建系统。
	\section{实验方法}
	\section{实验结果}
	\subsection{数据}
	\subsection{图表}
	\subsubsection{实验条件}
	\subsubsection{实验过程}
	\subsection{结果分析}
	\section{结论}
	\section{致谢}
\end{document}
```

关于ctex的使用命令，请大家使用ctex的使用手册。



全部命令如下：

```latex
%%%来自：[P5_latex05_LaTe文档的基本结构](https://www.bilibili.com/video/BV1Vb411p7ko?p=5)

\documentclass{ctexart}

%\usepackage{ctex}

% ========== 设置标题的格式 =============
\ctexset {
	section = {
		format+ = \zihao{-4} \heiti \raggedright,
		name = {,、},
		number = \chinese{section},
		beforeskip = 1.0ex plus 0.2ex minus .2ex,
		afterskip = 1.0ex plus 0.2ex minus .2ex,
		aftername = \hspace{0pt}
	},
	subsection = {
		format+ = \zihao{5} \heiti \raggedright,
		% name={\thesubsection、},
		name = {,、},
		number = \arabic{subsection},
		beforeskip = 1.0ex plus 0.2ex minus .2ex,
		afterskip = 1.0ex plus 0.2ex minus .2ex,
		aftername = \hspace{0pt}
	}
}




\begin{document}
	\section{引言}
	近年来，随着逆向工程和三维重建技术的发展和应用，获取现实世界中物体的三维数据的方法越来越多的关注和研究，很多研究机构和商业公司都陆续推出了自己的三维重建系统。
	
	近年来，随着逆向工程和三维重建技术的发展和应用，获取现实世界中物体的三维数据的方法越来越多的关注和研究。\par 很多研究机构和商业公司都陆续推出了自己的三维重建系统。
	\section{实验方法}
	\section{实验结果}
	\subsection{数据}
	\subsection{图表}
	\subsubsection{实验条件}
	\subsubsection{实验过程}
	\subsection{结果分析}
	\section{结论}
	\section{致谢}
\end{document}
```



## 2.ctexbook的基本结构

使用ctexbook的命令，`\chapter`的使用：

```latex
%%%来自：[P5_latex05_LaTe文档的基本结构](https://www.bilibili.com/video/BV1Vb411p7ko?p=5)

\documentclass{ctexbook}

%\usepackage{ctex}

% ========== 设置标题的格式 =============
\ctexset {
	section = {
		format+ = \zihao{-4} \heiti \raggedright,
		name = {,、},
		number = \chinese{section},
		beforeskip = 1.0ex plus 0.2ex minus .2ex,
		afterskip = 1.0ex plus 0.2ex minus .2ex,
		aftername = \hspace{0pt}
	},
	subsection = {
		format+ = \zihao{5} \heiti \raggedright,
		% name={\thesubsection、},
		name = {,、},
		number = \arabic{subsection},
		beforeskip = 1.0ex plus 0.2ex minus .2ex,
		afterskip = 1.0ex plus 0.2ex minus .2ex,
		aftername = \hspace{0pt}
	}
}




\begin{document}
	\chapter{绪论}
	\section{研究的目的和意义}
	\section{国内外研究现状}
	\subsection{国外研究现状}
	\subsection{国内研究现状}
	
	\section{研究内容}
	\section{研究方法与技术路线}
	\subsection{研究内容}
	\subsection{技术路线}
	
	\chapter{实验与结果分析}
	\section{引言}
	\section{实验方法}
	\section{实验结果}
	\subsection{数据}
	\subsection{图表}
	\subsubsection{实验条件}
	\subsubsection{实验过程}
	\subsection{结果分析}
	\section{结论}
	\section{致谢}
\end{document}
```



此时，按照章节，生成了文档大纲。注意，测试的`\subsubsection`命令是不起作用的。

![](C:\Users\Acer\Documents\LaTex\read_me\md_pictures\latex05_02.png)



同时，还可以使用`\tableofcontents`来产生文档的目录。

还可以在搜索栏输入`texdoc ctex`命令，打开	ctex的宏包手册。在第7节，可以查阅`\ctexset`命令的详细使用方法。在导言区进行格式的设置，内容与格式分离。是latex排版的基本思想。



大家在使用latex时，一定要养成内容与格式分离的习惯。

全部代码如下：

```latex
\documentclass{ctexbook}

%\usepackage{ctex}

% ========== 设置标题的格式 =============
\ctexset {
	section = {
		format+ = \zihao{-4} \heiti \raggedright,
		name = {,、},
		number = \chinese{section},
		beforeskip = 1.0ex plus 0.2ex minus .2ex,
		afterskip = 1.0ex plus 0.2ex minus .2ex,
		aftername = \hspace{0pt}
	},
	subsection = {
		format+ = \zihao{5} \heiti \raggedright,
		% name={\thesubsection、},
		name = {,、},
		number = \arabic{subsection},
		beforeskip = 1.0ex plus 0.2ex minus .2ex,
		afterskip = 1.0ex plus 0.2ex minus .2ex,
		aftername = \hspace{0pt}
	}
}




\begin{document}
	\tableofcontents
	
	\chapter{绪论}
	\section{研究的目的和意义}
	\section{国内外研究现状}
	\subsection{国外研究现状}
	\subsection{国内研究现状}
	
	\section{研究内容}
	\section{研究方法与技术路线}
	\subsection{研究内容}
	\subsection{技术路线}
	
	\chapter{实验与结果分析}
	\section{引言}
	\section{实验方法}
	\section{实验结果}
	\subsection{数据}
	\subsection{图表}
	\subsubsection{实验条件}
	\subsubsection{实验过程}
	\subsection{结果分析}
	\section{结论}
	\section{致谢}
\end{document}
```

