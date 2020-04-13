

# 笔记【P10_latex10_LaTeX数学公式初步】

来自：[P10_latex10_LaTeX数学公式初步](https://www.bilibili.com/video/BV1Vb411p7ko?p=10)

```latex
%%%  P10_latex10_LaTeX数学公式初步
% 导言区
\documentclass{ctexart}%ctexbook, ctexrep

\usepackage{ctex}
\usepackage{amsmath}

% 正文区（文稿区）
\begin{document}
	\section{简介}
	\LaTeX{}将排版内容分为文本模式和数学模式。文本模式用于普通文本排版，数学模式用于数学公式排版。
	\section{行内公式}
	\subsection{美元符号}
	交换律是 $a+b=b+a$，如 $1+2=2+1=3$。
	\subsection{小括号}
	交换律是 \(a+b=b+a\)，如 \(1+2=2+1=3\)。
	\subsection{math环境}
	交换律是 \begin{math}a+b=b+a\end{math}，如 \begin{math}1+2=2+1=3\end{math}。
	
	\section{上下标}
	\subsection{上标}
	$3x^{20}-x+2 = 0$
	
	$3x^{3x^{20}-x+2}-x+2 = 0$
	\subsection{下标}
	$a_0, a_1, a_2$
	
	$a_0, a_1, a_2, ..., a_{3x^{20}-x+2}$
	\section{希腊字母}
	$\alpha$
	$\beta$
	$\gamma$
	$\epsilon$
	$\omega$
	
	$\Gamma$
	$\Delta$
	$\Theta$
	$\Pi$
	$\Omega$
	
	$\alpha^3 + \beta^2 + \gamma = 0$
	\section{数学函数}
	$\log$
	$\sin$
	$\cos$
	$\arcsin$
	$\arccos$
	$\ln$
	
	$\sin^2 x +\cos^2 x =1$
	$y - \arcsin x$
	
	$y = \sin^{-1} x$
	$y = \log_2 x$
	$y = \ln x$
	
	$\sqrt{2}$
	$\sqrt{x^2 + y^2}$
	$\sqrt{2 + \sqrt{2}}$
	$\sqrt[4]{x}$   %开4次方
	
	\section{分式}
	大约是原体积的$3/4$。
	大约是原体积的$\frac{3}{4}$。
	
	$\frac{x}{x^2 + x + 1}$
	
	$\frac{1}{1 + \frac{1}{x}}$
	
	$\sqrt{\frac{x}{x^2 + x +1}}$
	
	\section{行间公式}
	\subsection{美元符号}
	交换律是 
	$$a+b=b+a$$
	如
	 $$1+2=2+1$$
	
	\subsection{中括号}
	交换律是 
	\[a+b=b+a\]
	如
	\[1+2=2+1\]
	
	\subsection{displaymath环境}
	交换律是 
	\begin{displaymath}
		a+b=b+a,
	\end{displaymath},
	如
	\begin{displaymath}
		1+2=2+1
	\end{displaymath}
	
	\subsection{自动编号公式equation环境}
	交换律见式\ref{eq:commutative}
	\begin{equation}
		a+b=b+a \label{eq:commutative} %添加标签
	\end{equation}
	
	\subsection{不编号公式equation*环境}
	%交换律见式\ref{eq:commutative2}
	\begin{equation*}
	a+b=b+a %\label{eq:commutative2} %添加标签
	\end{equation*}

	公式的编号与交叉引用也是自动实现的，大家在排版中，要习惯于采用自动化的方式处理诸如图、表、公式的编号与交叉引用。再如公式\ref{eq:pol}：
	\begin{equation}
		x^5 -7x^3 + 4x = 0 \label{eq:pol}
	\end{equation}
	
\end{document}

```

