%% File: aguplus.cls
%% =============================================
%% IMPORTANT NOTICE:
%% See the copyright and distribution conditions below.
%% =============================================
%% AGU++ (LaTeX2e Class file)
%% ---------------------------------
%% An unofficial LaTeX extension to
%% the official AGU package AGUTeX
%% ---------------------------------
%% Copyright 1993-1999 Patrick W Daly
%% Max-Planck-Institut f\"ur Aeronomie
%% Max-Planck-Str. 2
%% D-37191 Katlenburg-Lindau
%% Germany
%% E-mail: daly@linmpi.mpg.de
%%
%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN
%% archives in directory macros/latex/base/lppl.txt; either
%% version 1 of the License, or any later version.
%%
%% This is a contributed file to the LaTeX2e system.
%%
\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{aguplus}
          [1999/08/19 1.6b (PWD)]
 % THIS IS A LATEX2E CLASS FILE; it will not work with LaTeX 2.09
 % This is AGU++, an extension to the AGU official package AGUTeX
 % It fixes up some problems with AGUTeX, adds many extra features
 %  including putting figures, plates, tables in the text,
 %  decent author-year citations and BibTeX support,
 %  \title, \author, \affil allowed in preamble,
 %  supplemental abstract for JGR,
 %  balanced columns on last preprint page,
 %  sublabelling of counters figure, plate, table, equation.
 %
 %  This package MUST be used in conjunction with one of the AGUTeX packages,
 %  (version 4.0 or earlier)
 %  which are given as options to the class, as for example:
 %  \documentclass[agupp]{aguplus}
 %  Other possible AGUTeX packages are: agums, agupp, jgrga, grlga, tecga,
 %                                      radga, rtjga, paleo
 %
 %  See the manual AGUPLUS.TEX for details.
 %--------------------------------------------------------------------
\def\getAGU{\edef\AGUpack{\CurrentOption}}
\DeclareOption{agums}{\getAGU\PassOptionsToClass{12pt}{article}}
\DeclareOption{agupp}{\getAGU}
\DeclareOption{jgrga}{\getAGU}
\DeclareOption{grlga}{\getAGU}
\DeclareOption{tecga}{\getAGU}
\DeclareOption{radga}{\getAGU}
\DeclareOption{paleo}{\getAGU}
\DeclareOption{rtjga}{\getAGU}
\DeclareOption{tighten}{\AtEndOfClass{\tighten}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
\LoadClass{article}
\@ifundefined{AGUpack}
{\ClassError{aguplus}
   {No valid AGUTeX package given as option}
   {Valid AGUTeX package names are:\MessageBreak
    agums, agupp, jgrga, grlga, radga, rtjga, tecga, paleo}
   \stop}{}
\newdimen\@maxsep \newdimen\@dblmaxsep
\let\ori@LaTeX=\LaTeX
\let\ori@caption=\caption
\let\ori@thetable=\thetable
\let\ori@sect=\@sect
\InputIfFileExists{\AGUpack.sty}
   {}
   {\ClassError{aguplus}
        {File \AGUpack.sty does not exist}
        {Make \AGUpack.sty accessible}
   \stop}
\let\LaTeX=\ori@LaTeX \let\ori@LaTeX\relax
\let\caption=\ori@caption \let\ori@caption\relax
\let\thetable=\ori@thetable \let\ori@thetable\relax
\let\@sect=\ori@sect \let\ori@sect\relax
\providecommand{\GetFileInfo}[1]{%
  \def\packname{#1}%
  \def\@tempb##1 ##2 ##3\relax##4\relax{%
    \def\packdate{##1}%
    \def\packversion{##2}
    \def\packinfo{##3}}%
  \edef\@tempa{\csname ver@#1\endcsname}%
  \expandafter\@tempb\@tempa\relax? ? \relax\relax}
\GetFileInfo{aguplus.cls}
\newcommand{\optionlogo}{AGU$^{++}$}
\renewcommand\revtex@pageid{%
  \vspace{2em}\footnoterule{\footnotesize \parindent1.5em
  This \revtex@genre\space was prepared with
   \revtex@org{'s}\space \LaTeX\ macros v\revtex@ver,
   with the extension package `\optionlogo' by P.~W. Daly, version
    \packversion\ from \packdate.}}
\newif\if@draft
\newif\if@preprint
\newif\if@camera
\def\@tempa{manuscript}
\ifx\revtex@genre\@tempa\@drafttrue\else\@draftfalse\fi
\def\@tempa{preprint}
\ifx\revtex@genre\@tempa\@preprinttrue\else\@preprintfalse\fi
\def\@tempa{galley}
\ifx\revtex@genre\@tempa\@cameratrue\else\@camerafalse\fi
\renewcommand{\@seccntformat}[1]{\sectype\csname the#1\endcsname
   \sectchar\hskip 1ex}
\def\@ssect#1#2#3#4#5{\@tempskipa #3\relax
   \ifdim \@tempskipa>\z@
     \begingroup #4
        \@hangfrom{\hskip #1}{\interlinepenalty \@M \sectype\ssectchar#5\par}
     \endgroup
   \else \def\@svsechd{#4\hskip #1\relax \sectype\ssectchar#5}\fi
    \@xsect{#3}}
\def\sectchar{.}  \def\ssectchar{} \def\sectype{}
\def\@hangfrom#1{\noindent#1}
\def\thesection{\@arabic{\c@section}}
\def\thesubsection{\thesection.\@arabic{\c@subsection}}
\def\thesubsubsection{\thesubsection.\@arabic{\c@subsubsection}}
\def\theparagraph{\thesubsubsection.\@arabic{\c@paragraph}:}
\def\sectionnumbers{\c@secnumdepth=3}
\let\agureferences=\references
\def\references{\noappendix\agureferences}
\let\aguacknows=\acknowledgments
\def\acknowledgments{\noappendix\aguacknows}
\let\acknowledgements=\acknowledgments
\let\aguacknow=\acknowledgment
\def\acknowledgment{\noappendix\aguacknow}
\let\acknowledgement=\acknowledgment
\if@preprint
\setlength{\columnsep}{.26in}
\newdimen\@fmwidth \@fmwidth=33pc
\def\auth@skip{12pt}
\def\affil@skip{5pt}
\def\agutitle#1{\@makeslugcmmnt
\hsize\@fmwidth
\par\noindent
\parbox{\@fmwidth}%
  {\pretolerance=10000
  \raggedright
  \Large\bf#1}}
\def\aguauthor#1{%
\par\vskip\auth@skip\noindent
\parbox{\@fmwidth}%
  {\pretolerance=10000
  \raggedright
  \large#1}
\gdef\auth@skip{12pt}}
\def\aguaffil#1{\par\vskip\affil@skip\noindent
\parbox{\@fmwidth}%
  {\pretolerance=10000
  \raggedright
  \small#1}}
\def\aguabs{\par\vspace{4ex}\noindent
\minipage{\@fmwidth}\pretolerance=100
\@rightskip=\z@ plus 2em\rightskip\@rightskip
\large
{\bf Abstract.}}

\def\endaguabs{\endminipage\vspace{2ex}}
\newbox\@abstract
\setbox\@abstract\vbox{}

\def\abstract{\global\setbox\@abstract\vbox\bgroup
   \aguabs}
\def\endabstract{\endaguabs\egroup}
\def\xmaketitle{
\par
 \begingroup
     \clearpage
     \twocolumn[\box\@title
         \box\@abstract
         \null]
         \global\@topnum\z@
       \thispagestyle{plain}
       \ifx\@titlenote\empty \else
         \global\@botnum\z@
         \long\def\@makefntext##1{##1}
         \footnotetext{{\parindent=1em\indent
             \let\@elt=\par\@titlenote}}
       \fi
  \endgroup
 \pt@width=\hsize
 \setcounter{footnote}{0}
 \global\let\xmaketitle\relax}
\def\lefthead#1{\gdef\@versohead{#1}}
\def\righthead#1{\gdef\@rectohead{#1}}
\let\agusection=\section
\def\section{\pagestyle{myheadings}
\if@twoside \markboth{\@versohead}{\@rectohead} \else
  \markright{\@versohead: \@rectohead} \fi
\xmaketitle\agusection}
\long\def\@makecaption#1#2{%
 \vskip 10\p@
 \setbox\@tempboxa\hbox{#1 #2}%
 \ifdim \wd\@tempboxa >\hsize
     #1 #2\par
   \else
     \hbox to\hsize{\hfil\box\@tempboxa\hfil}%
 \fi}
\def\fps@figure{tbp}
\def\fps@plate{tbp}
\def\fps@table{tbp}
\else
\let\agutitle=\title
\let\aguaffil=\affil
\let\aguauthor=\author
\def\xmaketitle{\par \hsize\wd\@title
\begingroup
 \box\@title
       \ifx\@titlenote\empty \else
         \global\@botnum\z@
         \long\def\@makefntext##1{##1}
         \footnotetext{{\parindent=10pt\indent
             \parskip=6pt\let\@elt=\par\@titlenote}}
       \fi
\endgroup
 \setcounter{footnote}{0}
 \global\let\xmaketitle\relax}
\let\aguabs=\abstract
\def\abstract{\xmaketitle\aguabs}
\let\aguendabs=\endabstract
\def\endabstract{\aguendabs\par}
\let\agusection=\section
\def\section{\xmaketitle\par\agusection}
\fi
\newbox\@title
\setbox\@title=\vbox{}

\def\title#1{\setbox\@title=\vbox{
   \let\@nodocument=\relax
   \agutitle{#1}}}
\def\author#1{\setbox\@title=\vbox{\hsize=\wd\@title
   \let\@nodocument=\relax
   \box\@title \aguauthor{#1}}}
\def\affil#1{\setbox\@title=\vbox{\hsize=\wd\@title
   \let\@nodocument=\relax
   \box\@title \aguaffil{#1}}}
\def\altaffiltext#1#2{\let\@elt=\relax
  \ifx\@titlenote\empty \def
  \@titlenote{\altaffilmark{#1}#2} \else
  \xdef\@titlenote{\@titlenote\@elt \altaffilmark{#1}#2}\fi}
\def\@titlenote{}
\let\maketitle=\xmaketitle
\let\date=\slugcomment
\newif\if@supabs \@supabsfalse
\def\extraabstract{\global\@supabstrue}
\if@camera
\begingroup
  \catcode `|=0 \catcode `[= 1
  \catcode`]=2 \catcode `\{=12 \catcode `\}=12
  \catcode`\^^M=13 \catcode`\\=12 %
|long|gdef|@preabs#1\begin{abstract}[|endgroup|begin[abstract]]%
|endgroup
\long\def\supabs{\newpage \thispagestyle{empty}%
  \parindent=1em
  \hsize=20pc \reset@font\footnotesize
  \noindent
  \hbox to \hsize{\hfil Paper number \@paperid}\par\vskip1em}
\def\endsupabs{\par\endinput}
\def\dosupabse{{\def\documentclass{\begingroup\set@literal\@preabs}
\let\abstract=\supabs\let\endabstract=\endsupabs
\input{\jobname}}}
\AtEndOfPackage{\AtEndDocument{\if@supabs\dosupabse\fi}}
\fi
\newenvironment{notation}[1]%
  {\ifx#1\item\ClassError{aguplus}{%
    The notation environment MUST have an argument:\MessageBreak
    the longest symbol to appear in the listing}%
    {Stop and add an argument to \protect\begin{notation}{sym}}\fi
   \noappendix\section*{Notation}\begin{list}{}{%
     \renewcommand\makelabel[1]{\hfill##1}%
     \settowidth{\labelwidth}{#1}%
     \setlength{\itemsep}{\z@}\setlength{\parsep}{\z@}%
     \setlength{\leftmargin}{\labelwidth}%
     \setlength{\labelsep}{1em}%
     \addtolength{\leftmargin}{\labelsep}}}{\end{list}}
\def\iftwocol#1#2{\if@draft#2\else#1\fi}
\def\afour{\textheight=24cm
           \if@draft \textwidth=15cm \fi
           \if@preprint \textwidth=17.4cm \columnsep=0.5cm
              \oddsidemargin=-0.5cm \evensidemargin=-0.9cm \hoffset=0pt\fi}
\def\theHplate{\arabic{plate}}
\if@preprint
 % Begin coding from agupp.sty version 3.1
\newbox\pt@box
\newdimen\pt@width
\newcount\pt@line
\newcount\pt@nlines
\newcount\pt@ncol
\def\colhead#1{\omit\hidewidth{#1}\hidewidth\global\advance\pt@ncol by\@ne}
\def\tablecaption#1{\gdef\pt@caption{#1}} \def\pt@caption{\relax}
\def\tablehead#1{\gdef\pt@head{\\[-1.2ex]\hline\relax\\[-1.7ex]
#1\hskip\tabcolsep\\[.7ex]\hline\relax\\[-1.5ex]}}
\def\tabletail#1{\gdef\pt@tail{#1}} \def\pt@tail{\relax}
\def\tablewidth#1{\pt@width=#1} \pt@width\textwidth
\def\tableheadfrac#1{\gdef\pt@headfrac{#1}} \def\pt@headfrac{.1}
\let\figurewidth=\tablewidth
\def\pt@calcnlines{\@tempdima\pt@headfrac\textheight
\@tempdimb\textheight\advance\@tempdimb by-\@tempdima
\@tempdima\arraystretch\baselineskip
\divide\@tempdimb by\@tempdima
\global\pt@nlines\@tempdimb
}
\def\pt@tabular{\hbox \bgroup $\let\@acol\@ptabacol
\let\@classz\@tabclassz
\let\@classiv\@tabclassiv \let\\\@tabularcr\@tabarray}
\def\@ptabacol{\edef\@preamble{\@preamble \hskip \tabcolsep\tabskip\fill}}
\def\fnum@ptable{{\bf Table \thetable.}}
\def\fnum@ptablecont{{\bf Table \thetable.} ({\rm continued})}
\let\set@mkcaption=\relax
\def\set@mkcaptioncont{\long\def\@makecaption##1##2{
\hbox to\pt@width{##1\hfil}\vskip -0.8ex}}
\renewenvironment{planotable}[1]{\def\pt@format{\string#1}%
\def\pt@head{\\[-1.2ex]\hline\relax\\[-1.7ex]}\pt@width\textwidth%
\let\ltx@label=\label\gdef\pt@label{\let\label=\ltx@label}%
\def\label##1{\gdef\pt@labeltag{##1}%
        \gdef\pt@label{\ltx@label{\pt@labeltag}\let\label=\ltx@label}}
\set@tblnotetext\pt@ncol=0}%
{\crcr\noalign{\vskip .7ex}\hline\endtabular%
\pt@width\wd\pt@box\center\item[]%
\caption{\pt@caption}\mbox{\box\pt@box}\spew@ptblnotes%
\endcenter\pt@label\pt@endfloat}
\def\startdata{\pt@line=0\pt@calcnlines%
\ifdim\pt@width>\z@\def\@halignto{to \pt@width}\else\def\@halignto{}\fi%
\ifdim\pt@width>\columnwidth
   \let\pt@float\@dblfloat\let\pt@endfloat\end@dblfloat \else
   \let\pt@float\@float\let\pt@endfloat\end@float \fi
\let\fnum@table=\fnum@ptable\set@mkcaption%
\pt@float{table}%
\setbox\pt@box=\pt@tabular{\pt@format}\pt@head}
\def\pt@nl{\global\advance\pt@line by\@ne%
\ifnum\pt@line=\pt@nlines%
\\\noalign{\vskip .7ex}\hline\endtabular%
\pt@width\wd\pt@box\center\item[]%
\caption{\pt@caption}\mbox{\box\pt@box}%
\endcenter\pt@endfloat%\clearpage%   %%%%%%%%% PWD: remove \clearpage
\addtocounter{table}{\m@ne}%
\let\fnum@table=\fnum@ptablecont\set@mkcaptioncont%
\pt@float{table}%
\global\pt@ncol=0%
\setbox\pt@box=\pt@tabular{\pt@format}\pt@head%
\global\pt@line=0%
\else\\
\fi}
\let\nl=\pt@nl
\let\nextline=\pt@nl
\def\tablevspace#1{\noalign{\vskip{#1}}}
\def\tablebreak{\pt@line\pt@nlines\advance\pt@line by\m@ne\pt@nl}
\def\cutinhead#1{\noalign{\vskip 1.5ex}
\multicolumn{\pt@ncol}{c}{\it#1}\pt@nl
\noalign{\vskip .8ex}}
\def\sidehead#1{\noalign{\vskip 1.5ex}
\multicolumn{\pt@ncol}{@{\hskip\z@}l}{#1}\pt@nl
\noalign{\vskip .5ex}}
\def\set@tblnotetext{\def\tablenotetext##1##2{{%
\@temptokena={\vspace{0ex}{%
\parbox{\pt@width}{\hskip1em$^{\rm ##1}$##2}\par}}%
\@temptokenb=\expandafter{\tblnote@list}
\xdef\tblnote@list{\the\@temptokenb\the\@temptokena}}}}
\def\spew@ptblnotes{
\ifx\tblnote@list\@empty\relax
\else
\par
\vspace{2ex}
{\tblnote@list}
\gdef\tblnote@list{}
\fi}
\def\tablerefs#1{\@temptokena={\vspace*{3ex}{%
\parbox{\pt@width}{\hskip1em\rm #1}\par}}%
\@temptokenb=\expandafter{\tblnote@list}
\xdef\tblnote@list{\the\@temptokenb\the\@temptokena}}
\def\tablecomments#1{\@temptokena={\vspace*{3ex}{%
\parbox{\pt@width}{\hskip1em\rm #1}\par}}%
\@temptokenb=\expandafter{\tblnote@list}
\xdef\tblnote@list{\the\@temptokenb\the\@temptokena}}
 % End of coding from agupp.sty version 3.1
\else
  \let\ori@plano\planotable
  \renewcommand\planotable[1]{%
     \@ifundefined{totaltabdp}{}{\setlength{\totaltabdp}{0pt}}%
     \refstepcounter{table}\addtocounter{table}{\m@ne}\ori@plano{#1}}
\fi
\def\tablenum#1{\def\thetable{#1}\let\@currentlabel\thetable
  \addtocounter{table}{\m@ne}}
%% Copyright 1993-1999 Patrick W Daly
%% Max-Planck-Institut f\"ur Aeronomie
%% Max-Planck-Str. 2
%% D-37191 Katlenburg-Lindau
%% Germany
%% E-mail: daly@linmpi.mpg.de
\def\ModuleVersion#1[#2]{}
    \ModuleVersion{sublabel}
       [1999/02/23 4.5 (PWD)]
\@ifundefined{iffigcaps}{}
  {\PackageWarningNoLine{sublabel}
     {***********************************\MessageBreak
      This package read in after `figcaps'\MessageBreak
      There could be problems with sublabelled\MessageBreak
      figure and table numbers.\MessageBreak
      ***********************************}}
\newcommand{\substyle}{}
\def\substyle#1{\alph{#1}}
\newcommand{\sublabon}[1]{\@bsphack
\@ifundefined{c@#1}{%
    \PackageError{sublabel}
  {\protect\sublabon\space called for a non-existent counter}{\@eha}}
 {\@ifundefined{c@sb@#1}{\expandafter\newcount\csname c@sb@#1\endcsname
  \setcounter{sb@#1}{-1}}{}%
\ifnum\@nameuse{c@sb@#1}<0\else\sublaboff{#1}\fi
\stepcounter{#1}%
\setcounter{sb@#1}{0}%
\def\@tempa{eqnarray}\ifx \@tempa\@currenvir
    \addtocounter{equation}{-1}\setcounter{sb@equation}{1}\fi
\global\expandafter\let\csname @ldthe#1\expandafter\endcsname
    \csname the#1\endcsname
\expandafter\gdef\csname the#1\endcsname{%
   \@nameuse{@ldthe#1}{\substyle{sb@#1}}}
}\@esphack}
\newcommand{\sublaboff}[1]{\@bsphack
\@ifundefined{c@#1}{%
    \PackageError{sublabel}
  {\protect\sublaboff\space called for a non-existent counter}{\@eha}}
 {\@ifundefined{c@sb@#1}{%
    \PackageWarning{sublabel}
 {\protect\sublaboff{#1} called without any previous
    \MessageBreak
  \protect\sublabon{#1} command}}
 {\ifnum\@nameuse{c@sb@#1}<0
    \PackageWarning{sublabel}
 {\protect\sublaboff{#1} called without a previous
    \MessageBreak
  \protect\sublabon{#1} command being active}\else
\ifnum\@nameuse{c@sb@#1}=0\addtocounter{#1}{-1}\fi
\setcounter{sb@#1}{-1}%
\global\expandafter\let\csname the#1\expandafter\endcsname
    \csname @ldthe#1\endcsname
\def\@tempa{eqnarray}\ifx \@tempa\@currenvir
    \stepcounter{equation}\fi
\fi}}\@esphack}
\AtBeginDocument{%
\let\@ldstepcounter=\stepcounter
\renewcommand{\stepcounter}[1]
 {\@ifundefined{c@sb@#1}{\@ldstepcounter{#1}}{\ifnum
  \@nameuse{c@sb@#1}<0\relax
  \@ldstepcounter{#1}\else \@ldstepcounter{sb@#1}\fi}%
}
\let\@ldaddtoctr=\addtocounter
\renewcommand{\addtocounter}[2]
 {\@ifundefined{c@sb@#1}{\@ldaddtoctr{#1}{#2}}{\ifnum
  \@nameuse{c@sb@#1}<0\relax
  \@ldaddtoctr{#1}{#2}\else \@ldaddtoctr{sb@#1}{#2}\fi}%
}
\let\@ldendeqnarray=\endeqnarray
\renewcommand{\endeqnarray}{\@ldendeqnarray
  \@ifundefined{c@sb@equation}{}{\ifnum\c@sb@equation<0\else
  \@ldaddtoctr{equation}{1}\@ldaddtoctr{sb@equation}{-1}\fi}}
}
%% Copyright 1993-1999 Patrick W Daly
%% Max-Planck-Institut f\"ur Aeronomie
%% Max-Planck-Str. 2
%% D-37191 Katlenburg-Lindau
%% Germany
%% E-mail: daly@linmpi.mpg.de
\def\ModuleVersion#1[#2]{}
    \ModuleVersion{appendix}
           [1999/02/23 2.1 (PWD)]
\@ifundefined{iffigcaps}{}
  {\PackageWarningNoLine{appendix}
     {***********************************\MessageBreak
      This package read in after `figcaps'\MessageBreak
      There could be problems with sublabelled\MessageBreak
      figure and table numbers.\MessageBreak
      ***********************************}}
\providecommand{\appendixname}{Appendix}
\let\orisection=\section
\let\theolds=\thesection
\let\theoldss=\thesubsection
\let\orisubsection=\subsection
\def\appendix{\par
  \setcounter{section}{0}
  \setcounter{subsection}{0}
  \def\thesection{\Alph{section}}
  \def\thesubsection{\thesection\arabic{subsection}}
  \setcounter{secnumdepth}{3}
  \@addtoreset{equation}{section}
  \setcounter{equation}{0}
  \def\theequation{\thesection\arabic{equation}}
  \@addtoreset{figure}{section}
  \setcounter{figure}{0}
  \def\thefigure{\thesection\arabic{figure}}
  \@addtoreset{table}{section}
  \def\thetable{\thesection\arabic{table}}
  \setcounter{table}{0}
  \@ifundefined{c@plate}{\newcounter{plate}}{}
  \@addtoreset{plate}{section}
  \def\theplate{\thesection\arabic{plate}}
  \setcounter{plate}{0}
  \def\@Alph##1{\ifcase##1A\or A\or B\or C\or D\else\@Ialph{##1}\fi}
 \def\section{\@sectiontrue\orisection}
  \def\sectype{\if@section\appendixname~\fi}
  \def\sectchar{\if@section:\else.\fi}
  \def\ssectchar{\if@section\unskip:~\else\fi}
   \def\subsection{\@sectionfalse\orisubsection}
}
\newif\if@section \@sectionfalse
\def\noappendix{\setcounter{secnumdepth}{0}
  \global\let\section=\orisection
  \global\let\thesection=\theolds
  \global\let\thesubsection=\theoldss
  \gdef\sectchar{.} \gdef\ssectchar{}
  \gdef\sectype{}
  \global\let\subsection=\orisubsection
}
%% Copyright 1993-1999 Patrick W Daly
%% Max-Planck-Institut f\"ur Aeronomie
%% Max-Planck-Str. 2
%% D-37191 Katlenburg-Lindau
%% Germany
%% E-mail: daly@linmpi.mpg.de
\def\ModuleVersion#1[#2]{}
    \ModuleVersion{figcaps}
        [1999/02/23 4.7 (PWD)]
\@ifundefined{chapter}{}{%
    \PackageError{figcaps}
     {`figcaps' may only be used with article-like classes}
     {There is no help. You just cannot use `figcaps'}}
\newif\iffigcaps \figcapstrue
\newif\iffigmark \figmarkfalse
\newif\if@figpage \@figpagefalse
\@ifundefined{figurecapname}{\def\figurecapname{Figure Captions}}{}
\@ifundefined{tablepagename}{\def\tablepagename{Tables}}{}
\@ifundefined{figurepagename}{\def\figurepagename{Figures}}{}
\begingroup
  \catcode `|=0 \catcode `[= 1
  \catcode`]=2 \catcode `\{=12 \catcode `\}=12
  \catcode`\^^M=13 \catcode`\\=12 %
|long|gdef|@vfig#1\end{figure}[|def|@term[\end{figure}]%
          |expandafter|writelof#1^^M\end{figure}^^M|end[figure]]%
|long|gdef|@vsfig#1\end{figure*}[|def|@term[\end{figure*}]%
          |expandafter|writelof#1^^M\end{figure*}^^M|end[figure*]]%
|long|gdef|@vtab#1\end{table}[|def|@term[\end{table}]%
          |expandafter|writelot#1^^M\end{table}^^M|end[table]]%
|long|gdef|@vstab#1\end{table*}[|def|@term[\end{table*}]%
          |expandafter|writelot#1^^M\end{table*}^^M|end[table*]]%
 |long|gdef|@vltab#1\end{longtable}[|def|@term[\end{longtable}]%
           |expandafter|writelot#1^^M\end{longtable}^^M|end[longtable]]%
|long|gdef|@vpla#1\end{plate}[|def|@term[\end{plate}]%
          |expandafter|writelof#1^^M\end{plate}^^M|end[plate]]%
|long|gdef|@vspla#1\end{plate*}[|def|@term[\end{plate*}]%
          |expandafter|writelof#1^^M\end{plate*}^^M|end[plate*]]%
 |long|gdef|@vptab#1\end{planotable}[|def|@term[\end{planotable}]%
           |expandafter|writelot#1^^M\end{planotable}^^M|end[planotable]]%
  |endgroup
\long\def\FC@writefile#1#2{\@ifundefined{tf@#1}{}{%
  \immediate\write\csname tf@#1\endcsname{#2}}}
\def\lof{lof} \def\lot{lot}

{\catcode`\^^M=13%
  \long\gdef\writelof#1^^M{\def\@tempb{#1}%
      \ifx\@tempb\@term\let\@tempa\relax\else
      \if@filesw\FC@writefile{pof}{#1}\fi\let\@tempa\writelof\fi \@tempa}
  \long\gdef\writelot#1^^M{\def\@tempb{#1}%
      \ifx\@tempb\@term\let\@tempa\relax\else
      \if@filesw\FC@writefile{pot}{#1}\fi\let\@tempa\writelot\fi \@tempa}
}
\def\figcapson{\figcapstrue}
\def\figcapsoff{\figcapsfalse}
\def\figmarkon{\figmarktrue}
\def\figmarkoff{\figmarkfalse}
\def\figure{\iffigcaps \let\@tempb=\@zfigure \else \let\@tempb=\@float\fi
  \@tempb{figure}}
\def\@zfigure#1{\begingroup\set@literal\@ifnextchar[{\@figure}{\@figure[]}}
\def\@figure[#1]{\@ifundefined{tf@pof}{\newwrite\tf@pof
     \if@filesw\immediate\openout\tf@pof\jobname.\lof\relax
     \ifFC@appendix\FC@writefile{pof}{\string\doappendix}\fi\fi}{}%
  \refstepcounter{figure}\iffigmark\marginpar{\fbox{\fnum@figure}}\fi
  \def\@captype{figure}\if@filesw\FC@writefile{pof}{\string\begin{figure}}\fi
  \@vfig}

\def\endfigure{\iffigcaps
    \endgroup\if@filesw\FC@writefile{pof}{\string\end{figure}}\fi\else
    \end@float\fi}

\@namedef{figure*}{\iffigcaps \let\@tempb=\@zsfigure \else
  \let\@tempb=\@dblfloat\fi \@tempb{figure}}
\def\@zsfigure#1{\begingroup\set@literal\@ifnextchar[{\@sfigure}{\@sfigure[]}}
\def\@sfigure[#1]{\@ifundefined{tf@pof}{\newwrite\tf@pof
     \if@filesw\immediate\openout\tf@pof\jobname.\lof\relax
     \ifFC@appendix\FC@writefile{pof}{\string\doappendix}\fi\fi}{}%
  \refstepcounter{figure}\iffigmark\marginpar{\fbox{\fnum@figure}}\fi
  \def\@captype{figure}\if@filesw\FC@writefile{pof}{\string\begin{figure}}\fi
  \@vsfig}

\@namedef{endfigure*}{\iffigcaps\endfigure\else\end@dblfloat\fi}
\@ifundefined{c@plate}{\newcounter{plate}}{}

\def\plate{\iffigcaps \let\@tempb=\@zplate \else \let\@tempb=\@float\fi
  \@tempb{plate}}
\def\@zplate#1{\begingroup\set@literal\@ifnextchar[{\@plate}{\@plate[]}}
\def\@plate[#1]{\@ifundefined{tf@pof}{\newwrite\tf@pof
     \if@filesw\immediate\openout\tf@pof\jobname.\lof\relax
     \ifFC@appendix\FC@writefile{pof}{\string\doappendix}\fi\fi}{}%
  \refstepcounter{plate}\iffigmark\marginpar{\fbox{\fnum@plate}}\fi
  \def\@captype{plate}\if@filesw\FC@writefile{pof}{\string\begin{plate}}\fi
  \@vpla}

\def\endplate{\iffigcaps
    \endgroup\if@filesw\FC@writefile{pof}{\string\end{plate}}\fi\else
    \end@float\fi}

\@namedef{plate*}{\iffigcaps \let\@tempb=\@zsplate \else
  \let\@tempb=\@dblfloat\fi \@tempb{plate}}
\def\@zsplate#1{\begingroup\set@literal\@ifnextchar[{\@splate}{\@splate[]}}
\def\@splate[#1]{\@ifundefined{tf@pof}{\newwrite\tf@pof
     \if@filesw\immediate\openout\tf@pof\jobname.\lof\relax
     \ifFC@appendix\FC@writefile{pof}{\string\doappendix}\fi\fi}{}%
  \refstepcounter{plate}\iffigmark\marginpar{\fbox{\fnum@plate}}\fi
  \def\@captype{plate}\if@filesw\FC@writefile{pof}{\string\begin{plate}}\fi
  \@vspla}

\@namedef{endplate*}{\iffigcaps\endplate\else\end@dblfloat\fi}
\def\table{\iffigcaps \let\@tempb=\@ztable \else \let\@tempb=\@float\fi
  \@tempb{table}}
\def\@ztable#1{\begingroup\set@literal\@ifnextchar[{\@table}{\@table[]}}
\def\@table[#1]{\@ifundefined{tf@pot}{\newwrite\tf@pot
     \if@filesw\immediate\openout\tf@pot\jobname.\lot\relax
     \ifFC@appendix\FC@writefile{pot}{\string\doappendix}\fi\fi}{}%
  \refstepcounter{table}\iffigmark\marginpar{\fbox{\fnum@table}}\fi
  \def\@captype{table}\if@filesw\FC@writefile{pot}{\string\begin{table}}\fi
  \@vtab}

\def\endtable{\iffigcaps
   \endgroup\if@filesw\FC@writefile{pot}{\string\end{table}}\fi\else
   \spew@tblnotes
   \end@float\fi}

\@namedef{table*}{\iffigcaps \let\@tempb=\@zstable \else
  \let\@tempb=\@dblfloat\fi \@tempb{table}}
\def\@zstable#1{\begingroup\set@literal\@ifnextchar[{\@stable}{\@stable[]}}
\def\@stable[#1]{\@ifundefined{tf@pot}{\newwrite\tf@pot
     \if@filesw\immediate\openout\tf@pot\jobname.\lot\relax
     \ifFC@appendix\FC@writefile{pot}{\string\doappendix}\fi\fi}{}%
  \refstepcounter{table}\iffigmark\marginpar{\fbox{\fnum@table}}\fi
  \def\@captype{table}\if@filesw\FC@writefile{pot}
    {\string\begin{table}}%
    \fi\@vstab}

\@namedef{endtable*}{\iffigcaps\endtable\else
   \spew@tblnotes
   \end@dblfloat\fi}
\AtBeginDocument{\let\FC@ltab=\longtable
  \let\FC@endltab=\endlongtable
\def\longtable{\iffigcaps \let\@tempb=\@ltable \else
  \let\@tempb=\FC@ltab\fi \@tempb}
\def\@ltable{\begingroup\set@literal
     \@ifundefined{tf@pot}{\newwrite\tf@pot
     \if@filesw\immediate\openout\tf@pot\jobname.\lot\relax
     \ifFC@appendix\FC@writefile{pot}{\string\doappendix}\fi\fi}{}%
  \refstepcounter{table}\iffigmark\marginpar{\fbox{\fnum@table}}\fi
  \def\@captype{table}\if@filesw\FC@writefile{pot}
     {\string\begin{longtable}}\fi \@vltab}
\def\endlongtable{\iffigcaps
   \endgroup\if@filesw\FC@writefile{pot}{\string\end{longtable}}\fi\else
   \FC@endltab\fi}
\@ifpackageloaded{longtable}{%
\def\LT@makecaption#1#2#3{%
  \LT@mcol\LT@cols c{\hbox to\z@{\hss\parbox[t]\LTcapwidth{%
   \@makecaption{#1{#2}}{#3}%
    \endgraf\vskip\baselineskip}%
  \hss}}}}{}
\@ifpackageloaded{afterpage}{%
 \let\FC@afterpage=\afterpage
 \def\afterpage{\iffigcaps \let\@tempb\relax \else \let\@tempb\FC@afterpage\fi
   \@tempb}}{}
  }
\let\aguplano=\planotable
\let\endaguplano=\endplanotable

\def\planotable{\iffigcaps \let\@tempb=\@ptable \else
  \let\@tempb=\aguplano\fi \@tempb}
\def\@ptable{\begingroup\set@literal
     \@ifundefined{tf@pot}{\newwrite\tf@pot
     \if@filesw\immediate\openout\tf@pot\jobname.\lot\relax
     \ifFC@appendix\FC@writefile{pot}{\string\doappendix}\fi\fi}{}%
  \refstepcounter{table}\iffigmark\marginpar{\fbox{\fnum@table}}\fi
  \def\@captype{table}\if@filesw\FC@writefile{pot}
     {\string\begin{planotable}}\fi \@vptab}

\def\endplanotable{\iffigcaps
   \endgroup\if@filesw\FC@writefile{pot}{\string\end{planotable}}\fi\else
   \endaguplano\fi}
\def\tableofcontents{%
  \PackageWarningNoLine{figcaps}
   {Ignored: \protect\tableofcontents\space command}}
\def\listoffigures{%
  \PackageWarningNoLine{figcaps}
   {Ignored: \protect\listoffigures\space command}}
\def\listoftables{%
  \PackageWarningNoLine{figcaps}
   {Ignored: \protect\listoftables\space command}}
\def\listofplates{%
  \PackageWarningNoLine{figcaps}
   {Ignored: \protect\listofplates\space command}}
\def\addtocontents#1#2{\relax}
\def\addcontentsline#1#2#3{\relax}
{\catcode`\^^M=\active \gdef\cr@relax{\catcode`\^^M=\active \let^^M=\relax}}
\def\set@literal{\cr@relax \let\do\@makeother\dospecials}
\def\@figurecaps{\@ifundefined{tf@pof}{}{\if@filesw
  \immediate\closeout\tf@pof\fi
  \@ifundefined{appendixname}{}{\def\appendixname{}}
  \noappendix
  \parindent\z@
  \reset@figtab\clearpage\section*{\figurecapname}\vspace{1cm}%
    \@mkboth{\uppercase{\figurecapname}}{\uppercase{\figurecapname}}%
    \addcontentsline{toc}{section}{\figurecapname}%
  \def\figure{\def\addcontentsline####1####2####3{}%
    \def\@captype{figure}%
    \vbox\bgroup
   }\def\endfigure{\egroup\bigskip}%
  \def\plate{\def\addcontentsline####1####2####3{}%
    \def\@captype{plate}%
    \vbox\bgroup
   }\let\endplate=\endfigure
  {\let\@makecaption=\@makefcaption
  \def\@figbox##1##2##3{\relax}
  \@input{\jobname.\lof}}%
  \clearpage}}%
\def\@tablepage{\@ifundefined{tf@pot}{}{\if@filesw
  \immediate\closeout\tf@pot\fi
  \@ifundefined{appendixname}{}{\def\appendixname{}}
  \noappendix
  \parindent\z@
  \reset@figtab\clearpage\section*{\tablepagename}
    \@mkboth{\uppercase{\tablepagename}}{\uppercase{\tablepagename}}%
   \def\table{\def\@captype{table}\vbox\bgroup
   }\def\endtable{\spew@tblnotes\egroup\bigskip}%
   \let\planotable=\aguplano \let\endplanotable=\endaguplano
   \def\@float##1{\def\@captype{table}\vbox\bgroup}
   \let\@dblfloat=\@float \let\clearpage=\newpage
   \def\longtable{\newpage\FC@ltab} \let\endlongtable=\FC@endltab
  \@input{\jobname.\lot}
  \clearpage}}
\def\printfigures{\@figpagetrue}
\def\@figurepage{\if@figpage\@ifundefined{tf@pof}{}{%
  \@ifundefined{appendixname}{}{\def\appendixname{}}
  \noappendix \parindent\z@
  \reset@figtab\clearpage\section*{\figurepagename}%
  \@mkboth{\uppercase{\figurepagename}}{\uppercase{\figurepagename}}%
  \begingroup
  \def\figurewidth##1{\pt@width##1\hsize##1}
  \def\figure{\def\@captype{figure}\vbox\bgroup}\def\endfigure{\egroup
    \vspace{20pt}}%
  \let\platewidth=\figurewidth
  \def\plate{\def\@captype{plate}\vbox\bgroup}\let\endplate=\endfigure
  \def\label##1{}%
  \@input{\jobname.\lof}\newpage\endgroup}\fi}
\def\reset@figtab{%
  \setcounter{figure}{0}\setcounter{table}{0}
  \setcounter{plate}{0}
}
\AtEndDocument{\iffigcaps\@figurecaps\@tablepage\@figurepage\fi}
\let\@appendix=\appendix
\newif\ifFC@appendix \FC@appendixfalse
\def\appendix{\FC@appendixtrue
  \@ifundefined{tf@pof}{}{\if@filesw\FC@writefile{pof}{\string\doappendix}\fi}%
  \@ifundefined{tf@pot}{}{\if@filesw\FC@writefile{pot}{\string\doappendix}\fi}%
  \global\let\@section=\section
  \doappendix
  \let\@@section=\section
  \def\section{%
    \@ifundefined{tf@pof}{}{\if@filesw\FC@writefile{pof}{\string
        \stepcounter{section}}\fi}%
    \@ifundefined{tf@pot}{}{\if@filesw\FC@writefile{pot}{\string
        \stepcounter{section}}\fi}%
    \@@section}
  \global\let\reset@figtab=\@unappendix}
\def\doappendix{%
  \global\let\@thefigure=\thefigure
  \global\let\@thetable=\thetable
  \global\let\@theplate=\theplate
  \global\let\@cl@section=\cl@section
  \@appendix
}
\def\@unappendix{\FC@appendixfalse
  \setcounter{figure}{0}\setcounter{table}{0}
  \let\thefigure=\@thefigure
  \let\thetable=\@thetable
  \setcounter{plate}{0}%
  \let\theplate=\@theplate
  \let\cl@section=\@cl@section
  \let\section=\@section
}
\let\orisubon=\sublabon
\let\orisuboff=\sublaboff
\def\sublabon#1{\orisubon{#1}\if@filesw
    \iffigcaps\def\@tempb{#1}
    \def\@tempa{figure}\ifx\@tempa\@tempb
    \@ifundefined{tf@pof}{\newwrite\tf@pof
        \immediate\openout\tf@pof\jobname.\lof}{}%
    \FC@writefile{pof}{\string\orisubon{#1}}\fi
    \def\@tempa{plate}\ifx\@tempa\@tempb
    \@ifundefined{tf@pof}{\newwrite\tf@pof
        \immediate\openout\tf@pof\jobname.\lof}{}%
    \FC@writefile{pof}{\string\orisubon{#1}}\fi
    \def\@tempa{table}\ifx\@tempa\@tempb
    \@ifundefined{tf@pot}{\newwrite\tf@pot
        \immediate\openout\tf@pot\jobname.\lot}{}%
    \FC@writefile{pot}{\string\orisubon{#1}}\fi
\fi\fi}
\def\sublaboff#1{\orisuboff{#1}\if@filesw
    \iffigcaps\def\@tempb{#1}
    \def\@tempa{figure}\ifx\@tempa\@tempb
    \@ifundefined{tf@pof}{\newwrite\tf@pof
        \immediate\openout\tf@pof\jobname.\lof}{}%
    \FC@writefile{pof}{\string\orisuboff{#1}}\fi
    \def\@tempa{plate}\ifx\@tempa\@tempb
    \@ifundefined{tf@pof}{\newwrite\tf@pof
        \immediate\openout\tf@pof\jobname.\lof}{}%
    \FC@writefile{pof}{\string\orisuboff{#1}}\fi
    \def\@tempa{table}\ifx\@tempa\@tempb
    \@ifundefined{tf@pot}{\newwrite\tf@pot
        \immediate\openout\tf@pot\jobname.\lot}{}%
    \FC@writefile{pot}{\string\orisuboff{#1}}\fi
\fi\fi}
\def\figbox{\@ifstar{\let\agubox\makebox\@figbox}
  {\let\agubox\framebox\@figbox}}
\def\@figbox#1#2#3{\hbox to \hsize{\hfil
  \ifx!#1!\agubox{#3}\else
  \agubox[#1][c]{\ifx!#2!#3\else\@tempdima#2\relax
  \divide\@tempdima by2\relax
  \advance\@tempdima by-\fboxsep \advance\@tempdima by-\fboxrule
  \vrule\@height\@tempdima\@depth\@tempdima\@width\z@
  \vbox to \z@{\vss\hbox{#3}\vss}\fi}\fi\hfil}}
\figmarktrue
\if@preprint \figcapsfalse
  \def\figurewidth#1{\pt@width=\hsize}
  \def\platewidth#1{\pt@width=\hsize}
\fi
\if@draft
  \def\figurewidth#1{\pt@width=\hsize}
  \def\platewidth#1{\pt@width=\hsize}
\fi
\let\ori@makecap=\@makecaption
\def\@makefcaption#1#2{{\if@dblcap\if@camera\pt@width=\textwidth
 \ori@makecap{#1}{#2}
 \pt@width=\wpt@width
 \hsize=\pt@width
 \vskip10pt \def\label##1{}\fi\fi
 \ori@makecap{#1}{#2}}
}
\newdimen\wpt@width
\newif\if@dblcap \@dblcapfalse
\def\doublecaption#1{\wpt@width=#1\relax\@dblcaptrue}
%% Copyright 1993-1999 Patrick W Daly
%% Max-Planck-Institut f\"ur Aeronomie
%% Max-Planck-Str. 2
%% D-37191 Katlenburg-Lindau
%% Germany
%% E-mail: daly@linmpi.mpg.de
\def\ModuleVersion#1[#2]{}
    \ModuleVersion{natbib}
        [1999/05/28 7.0 (PWD)]
\newcommand\NAT@open{[} \newcommand\NAT@close{]}
\newcommand\NAT@sep{;} \newcommand\NAT@cmt{, }
\newcommand\NAT@aysep{,} \newcommand\NAT@yrsep{,~}
\def\NAT@sort{0}
\def\NAT@nmfmt#1{{\NAT@up#1}}
\renewcommand\@cite%
    [3]{\ifNAT@swa\NAT@@open\if*#2*\else#2\ \fi
        #1\if*#3*\else\NAT@cmt#3\fi\NAT@@close\else#1\fi\endgroup}
\providecommand\@firstofone[1]{#1}
\let\citenumfont=\relax
\def\@citex%
  [#1][#2]#3{%
  \NAT@sort@cites{#3}%
  \let\@citea\@empty
  \@cite{\let\NAT@nm\@empty\let\NAT@year\@empty
    \@for\@citeb:=\NAT@cite@list\do
    {\edef\@citeb{\expandafter\@firstofone\@citeb}%
     \if@filesw\immediate\write\@auxout{\string\citation{\@citeb}}\fi
     \@ifundefined{b@\@citeb\@extra@b@citeb}{\@citea%
       {\reset@font\bfseries ?}\NAT@citeundefined
                 \PackageWarning{natbib}%
       {Citation `\@citeb' on page \thepage \space undefined}\def\NAT@date{}}%
     {\let\NAT@last@nm=\NAT@nm\let\NAT@last@yr=\NAT@year
     \NAT@parse{\@citeb}%
     \ifNAT@full\let\NAT@nm\NAT@all@names\else
       \let\NAT@nm\NAT@name\fi
     \ifNAT@swa\ifcase\NAT@ctype
       \if\relax\NAT@date\relax
         \@citea\hyper@natlinkstart{\@citeb\@extra@b@citeb}%
         \NAT@nmfmt{\NAT@nm}\NAT@date\hyper@natlinkend
       \else
         \ifx\NAT@last@nm\NAT@nm\NAT@yrsep
            \ifx\NAT@last@yr\NAT@year
              \hyper@natlinkstart{\@citeb\@extra@b@citeb}\NAT@exlab
              \hyper@natlinkend
            \else\unskip\
              \hyper@natlinkstart{\@citeb\@extra@b@citeb}\NAT@date
              \hyper@natlinkend
            \fi
         \else\@citea\hyper@natlinkstart{\@citeb\@extra@b@citeb}%
           \NAT@nmfmt{\NAT@nm}%
           \hyper@natlinkbreak{\NAT@aysep\ }{\@citeb\@extra@b@citeb}%
           \NAT@date\hyper@natlinkend
         \fi
       \fi
     \or\@citea\hyper@natlinkstart{\@citeb\@extra@b@citeb}%
         \NAT@nmfmt{\NAT@nm}\hyper@natlinkend
     \or\@citea\hyper@natlinkstart{\@citeb\@extra@b@citeb}%
         \NAT@date\hyper@natlinkend
     \or\@citea\hyper@natlinkstart{\@citeb\@extra@b@citeb}%
         \NAT@alias\hyper@natlinkend
     \fi \def\@citea{\NAT@sep\ }%
     \else\ifcase\NAT@ctype
        \if\relax\NAT@date\relax
          \@citea\hyper@natlinkstart{\@citeb\@extra@b@citeb}%
          \NAT@nmfmt{\NAT@nm}\hyper@natlinkend
        \else
         \ifx\NAT@last@nm\NAT@nm\NAT@yrsep
            \ifx\NAT@last@yr\NAT@year
              \hyper@natlinkstart{\@citeb\@extra@b@citeb}\NAT@exlab
              \hyper@natlinkend
            \else\unskip\
              \hyper@natlinkstart{\@citeb\@extra@b@citeb}\NAT@date
              \hyper@natlinkend
            \fi
         \else\@citea\hyper@natlinkstart{\@citeb\@extra@b@citeb}%
           \NAT@nmfmt{\NAT@nm}%
           \hyper@natlinkbreak{\ \NAT@@open\if*#1*\else#1\ \fi}%
              {\@citeb\@extra@b@citeb}%
           \NAT@date\hyper@natlinkend\fi
        \fi
       \or\@citea\hyper@natlinkstart{\@citeb\@extra@b@citeb}%
         \NAT@nmfmt{\NAT@nm}\hyper@natlinkend
       \or\@citea\hyper@natlinkstart{\@citeb\@extra@b@citeb}%
         \NAT@date\hyper@natlinkend
       \or\@citea\hyper@natlinkstart{\@citeb\@extra@b@citeb}%
         \NAT@alias\hyper@natlinkend
       \fi \if\relax\NAT@date\relax\def\@citea{\NAT@sep\ }%
           \else\def\@citea{\NAT@@close\NAT@sep\ }\fi
     \fi
     }}\ifNAT@swa\else\if*#2*\else\NAT@cmt#2\fi
     \if\relax\NAT@date\relax\else\NAT@@close\fi\fi}{#1}{#2}}
\newif\ifNAT@par \NAT@partrue
\newcommand\NAT@@open{\ifNAT@par\NAT@open\fi}
\newcommand\NAT@@close{\ifNAT@par\NAT@close\fi}
\newcommand\NAT@alias{\@ifundefined{al@\@citeb\@extra@b@citeb}{%
  {\reset@font\bfseries(alias?)}\PackageWarning{natbib}
  {Alias undefined for citation `\@citeb'
  \MessageBreak on page \thepage}}{\@nameuse{al@\@citeb\@extra@b@citeb}}}
\let\NAT@up\relax
\newcommand\NAT@Up[1]{{\let\protect\@unexpandable@protect\let~\relax
  \expandafter\NAT@deftemp#1}\expandafter\NAT@UP\NAT@temp}
\newcommand\NAT@deftemp[1]{\xdef\NAT@temp{#1}}
\newcommand\NAT@UP[1]{\let\@tempa\NAT@UP\ifcat a#1\MakeUppercase{#1}%
  \let\@tempa\relax\else#1\fi\@tempa}
\renewcommand\@biblabel[1]{\hfill}
\AtBeginDocument{\ifx\SK@def\@undefined\else
\ifx\SK@cite\@empty\else
  \SK@def\@citex[#1][#2]#3{\SK@\SK@@ref{#3}\SK@@citex[#1][#2]{#3}}\fi
\ifx\SK@citeauthor\@undefined\def\HAR@checkdef{}\else
  \let\citeauthor\SK@citeauthor
  \let\citefullauthor\SK@citefullauthor
  \let\citeyear\SK@citeyear\fi
\fi}
\newif\ifNAT@full\NAT@fullfalse
\newif\ifNAT@swa
\DeclareRobustCommand\citet
   {\begingroup\NAT@swafalse\def\NAT@ctype{0}\NAT@partrue
     \@ifstar{\NAT@fulltrue\NAT@citetp}{\NAT@fullfalse\NAT@citetp}}
\newcommand\NAT@citetp{\@ifnextchar[{\NAT@@citetp}{\NAT@@citetp[]}}
\newcommand\NAT@@citetp{}
\def\NAT@@citetp[#1]{\@ifnextchar[{\@citex[#1]}{\@citex[][#1]}}
\DeclareRobustCommand\citep
   {\begingroup\NAT@swatrue\def\NAT@ctype{0}\NAT@partrue
         \@ifstar{\NAT@fulltrue\NAT@citetp}{\NAT@fullfalse\NAT@citetp}}
\DeclareRobustCommand\cite
    {\begingroup\def\NAT@ctype{0}\NAT@partrue\NAT@swatrue
      \@ifstar{\NAT@fulltrue\NAT@cites}{\NAT@fullfalse\NAT@cites}}
\newcommand\NAT@cites{\@ifnextchar [{\NAT@@citetp}{%
     \NAT@swafalse
    \NAT@@citetp[]}}
\DeclareRobustCommand\citealt
   {\begingroup\NAT@swafalse\def\NAT@ctype{0}\NAT@parfalse
         \@ifstar{\NAT@fulltrue\NAT@citetp}{\NAT@fullfalse\NAT@citetp}}
\DeclareRobustCommand\citealp
   {\begingroup\NAT@swatrue\def\NAT@ctype{0}\NAT@parfalse
         \@ifstar{\NAT@fulltrue\NAT@citetp}{\NAT@fullfalse\NAT@citetp}}
\DeclareRobustCommand\citeauthor
   {\begingroup\NAT@swafalse\def\NAT@ctype{1}\NAT@parfalse
    \@ifstar{\NAT@fulltrue\NAT@citetp}{\NAT@fullfalse\NAT@citetp}}
\DeclareRobustCommand\Citet
   {\begingroup\NAT@swafalse\def\NAT@ctype{0}\NAT@partrue
     \let\NAT@up\NAT@Up
     \@ifstar{\NAT@fulltrue\NAT@citetp}{\NAT@fullfalse\NAT@citetp}}
\DeclareRobustCommand\Citep
   {\begingroup\NAT@swatrue\def\NAT@ctype{0}\NAT@partrue
     \let\NAT@up\NAT@Up
         \@ifstar{\NAT@fulltrue\NAT@citetp}{\NAT@fullfalse\NAT@citetp}}
\DeclareRobustCommand\Citeauthor
   {\begingroup\NAT@swafalse\def\NAT@ctype{1}\NAT@parfalse
     \let\NAT@up\NAT@Up
    \@ifstar{\NAT@fulltrue\NAT@citetp}{\NAT@fullfalse\NAT@citetp}}
\DeclareRobustCommand\citeyear
   {\begingroup\NAT@swafalse\def\NAT@ctype{2}\NAT@parfalse\NAT@citetp}
\DeclareRobustCommand\citeyearpar
   {\begingroup\NAT@swatrue\def\NAT@ctype{2}\NAT@partrue\NAT@citetp}
\newcommand\citetext[1]{\NAT@open#1\NAT@close}
\DeclareRobustCommand\citefullauthor
   {\citeauthor*}
\newcommand\defcitealias[2]{%
   \@ifundefined{al@#1\@extra@b@citeb}{}
   {\PackageWarning{natbib}{Overwriting existing alias for citation #1}}
   \@namedef{al@#1\@extra@b@citeb}{#2}}
\DeclareRobustCommand\citetalias{\begingroup
   \NAT@swafalse\def\NAT@ctype{3}\NAT@parfalse\NAT@citetp}
\DeclareRobustCommand\citepalias{\begingroup
   \NAT@swatrue\def\NAT@ctype{3}\NAT@partrue\NAT@citetp}
\renewcommand\nocite[1]{\@bsphack
  \@for\@citeb:=#1\do{%
    \edef\@citeb{\expandafter\@firstofone\@citeb}%
    \if@filesw\immediate\write\@auxout{\string\citation{\@citeb}}\fi
    \if*\@citeb\else
    \@ifundefined{b@\@citeb\@extra@b@citeb}{%
       \NAT@citeundefined \PackageWarning{natbib}%
       {Citation `\@citeb' undefined}}{}\fi}%
  \@esphack}
\newcommand\NAT@parse[1]{{%
     \let\protect=\@unexpandable@protect\let~\relax
     \let\active@prefix=\@gobble
     \xdef\NAT@temp{\csname b@#1\@extra@b@citeb\endcsname}}%
     \expandafter\NAT@split\NAT@temp
     \expandafter\NAT@parse@date\NAT@date??????@@%
}
\newcommand\NAT@split[4]{%
  \gdef\NAT@num{#1}\gdef\NAT@name{#3}\gdef\NAT@date{#2}%
  \gdef\NAT@all@names{#4}%
  \ifx\NAT@noname\NAT@all@names \gdef\NAT@all@names{#3}\fi}
\newcommand\NAT@parse@date{}
\def\NAT@parse@date#1#2#3#4#5#6@@{%
  \ifnum\the\catcode`#1=11\def\NAT@year{}\def\NAT@exlab{#1}\else
  \ifnum\the\catcode`#2=11\def\NAT@year{#1}\def\NAT@exlab{#2}\else
  \ifnum\the\catcode`#3=11\def\NAT@year{#1#2}\def\NAT@exlab{#3}\else
  \ifnum\the\catcode`#4=11\def\NAT@year{#1#2#3}\def\NAT@exlab{#4}\else
    \def\NAT@year{#1#2#3#4}\def\NAT@exlab{{#5}}\fi\fi\fi\fi}
\newcommand\NAT@ifcmd{\futurelet\NAT@temp\NAT@ifxcmd}
\newcommand\NAT@ifxcmd{\ifx\NAT@temp\relax\else\expandafter\NAT@bare\fi}
\def\NAT@bare#1(#2)#3(@)#4\@nil#5{%
  \stepcounter{NAT@ctr}%
  \NAT@wrout{\arabic {NAT@ctr}}{#2}{#1}{#3}{#5}
}
\newcommand\NAT@wrout[5]{%
\if@filesw
      {\let\protect\noexpand\let~\relax
       \immediate
       \write\@auxout{\string\bibcite{#5}{{#1}{#2}{{#3}}{{#4}}}}}\fi
\ignorespaces}
\def\NAT@noname{{}}
\renewcommand\bibitem{%
  \@ifnextchar[{\@lbibitem}{%
    \stepcounter{NAT@ctr}\@lbibitem[\arabic{NAT@ctr}]}}
\def\@lbibitem[#1]#2{%
  \if\relax\@extra@b@citeb\relax\else
    \@ifundefined{br@#2\@extra@b@citeb}{}{%
     \@namedef{br@#2}{\@nameuse{br@#2\@extra@b@citeb}}}\fi
   \@ifundefined{b@#2\@extra@b@citeb}{\def\NAT@num{}}{\NAT@parse{#2}}%
   \item[\hfil\hyper@natanchorstart{#2\@extra@b@citeb}\@biblabel{\NAT@num}%
    \hyper@natanchorend]%
    \NAT@ifcmd#1(@)(@)\@nil{#2}}
\ifx\SK@lbibitem\@undefined\else
   \let\SK@lbibitem\@lbibitem
   \def\@lbibitem[#1]#2{%
     \SK@lbibitem[#1]{#2}\SK@\SK@@label{#2}\ignorespaces}\fi
\providecommand\bibcite{}
\renewcommand\bibcite[2]{\@ifundefined{b@#1\@extra@binfo}\relax
     {\NAT@citemultiple
      \PackageWarningNoLine{natbib}{Citation `#1' multiply defined}}%
  \global\@namedef{b@#1\@extra@binfo}{#2}}
\AtEndDocument{\NAT@swatrue\let\bibcite\NAT@testdef}
\newcommand\NAT@testdef[2]{%
  \def\NAT@temp{#2}\expandafter \ifx \csname b@#1\@extra@binfo\endcsname
    \NAT@temp \else \ifNAT@swa \NAT@swafalse
       \PackageWarningNoLine{natbib}{Citation(s) may have
          changed.\MessageBreak
          Rerun to get citations correct}\fi\fi}
\newcounter{NAT@ctr}
\let\aguthebib=\thebibliography
\def\thebibliography#1{\noappendix\aguthebib{#1}}
\providecommand\reset@font{\relax}
\providecommand\bibname{Bibliography}
\providecommand\refname{References}
\newcommand\NAT@citeundefined{\gdef \NAT@undefined {%
    \PackageWarningNoLine{natbib}{There were undefined citations}}}
\let \NAT@undefined \relax
\newcommand\NAT@citemultiple{\gdef \NAT@multiple {%
    \PackageWarningNoLine{natbib}{There were multiply defined citations}}}
\let \NAT@multiple \relax
\AtEndDocument{\NAT@undefined\NAT@multiple}
\providecommand\@mkboth[2]{}
\providecommand\MakeUppercase{\uppercase}
\providecommand{\@extra@b@citeb}{}
\gdef\@extra@binfo{}
\providecommand\hyper@natanchorstart[1]{}
\providecommand\hyper@natanchorend{}
\providecommand\hyper@natlinkstart[1]{}
\providecommand\hyper@natlinkend{}
\providecommand\hyper@natlinkbreak[2]{#1}
\AtBeginDocument{\@ifundefined{bbl@redefine}{}{%
\let\@citex\org@@citex
\bbl@redefine\@citex[#1][#2]#3{%
  \@safe@activestrue\org@@citex[#1][#2]{#3}\@safe@activesfalse}%
\bbl@redefine\NAT@testdef#1#2{%
  \@safe@activestrue\org@NAT@testdef{#1}{#2}\@safe@activesfalse}%
\@ifundefined{org@@lbibitem}{%
\bbl@redefine\@lbibitem[#1]#2{%
  \@safe@activestrue\org@@lbibitem[#1]{#2}\@safe@activesfalse}}{}%
}}
\ifnum\NAT@sort>0
\newcommand\NAT@sort@cites[1]{%
\@tempcntb\m@ne
\let\@celt\delimiter
\def\NAT@num@list{}%
\def\NAT@cite@list{}%
\def\NAT@nonsort@list{}%
\@for \@citeb:=#1\do{\NAT@make@cite@list}%
\edef\NAT@cite@list{\NAT@cite@list\NAT@nonsort@list}%
\edef\NAT@cite@list{\expandafter\NAT@xcom\NAT@cite@list @@}}
\begingroup \catcode`\_=8
\gdef\NAT@make@cite@list{%
     \edef\@citeb{\expandafter\@firstofone\@citeb}%
    \@ifundefined{b@\@citeb\@extra@b@citeb}{\def\NAT@num{A}}%
    {\NAT@parse{\@citeb}}%
      \ifcat _\ifnum\z@<0\NAT@num _\else A\fi
       \@tempcnta\NAT@num \relax
       \ifnum \@tempcnta>\@tempcntb
          \edef\NAT@num@list{\NAT@num@list \@celt{\NAT@num}}%
          \edef\NAT@cite@list{\NAT@cite@list\@citeb,}%
          \@tempcntb\@tempcnta
       \else
          \let\NAT@@cite@list=\NAT@cite@list \def\NAT@cite@list{}%
          \edef\NAT@num@list{\expandafter\NAT@num@celt \NAT@num@list \@gobble @}%
          {\let\@celt=\NAT@celt\NAT@num@list}%
       \fi
    \else
       \edef\NAT@nonsort@list{\NAT@nonsort@list\@citeb,}%
 \fi}
\endgroup
\def\NAT@celt#1{\ifnum #1<\@tempcnta
  \xdef\NAT@cite@list{\NAT@cite@list\expandafter\NAT@nextc\NAT@@cite@list @@}%
  \xdef\NAT@@cite@list{\expandafter\NAT@restc\NAT@@cite@list}%
 \else
  \xdef\NAT@cite@list{\NAT@cite@list\@citeb,\NAT@@cite@list}\let\@celt\@gobble%
 \fi}
\def\NAT@num@celt#1#2{\ifx \@celt #1%
     \ifnum #2<\@tempcnta
        \@celt{#2}%
        \expandafter\expandafter\expandafter\NAT@num@celt
     \else
        \@celt{\number\@tempcnta}\@celt{#2}%
  \fi\fi}
\def\NAT@nextc#1,#2@@{#1,}
\def\NAT@restc#1,#2{#2}
\def\NAT@xcom#1,@@{#1}
\else
 \newcommand\NAT@sort@cites[1]{\edef\NAT@cite@list{#1}}\fi
%% Copyright 1993-1999 Patrick W Daly
%% Max-Planck-Institut f\"ur Aeronomie
%% Max-Planck-Str. 2
%% D-37191 Katlenburg-Lindau
%% Germany
%% E-mail: daly@linmpi.mpg.de
\def\ModuleVersion#1[#2]{}
    \ModuleVersion{balance}
         [1999/02/23 4.3 (PWD)]
\newcommand{\@BAlancecol}{\if@twocolumn
  \setbox0=\vbox{\unvbox\@outputbox} \@tempdima=\ht0
  \advance\@tempdima by \topskip \advance\@tempdima
     by -\baselineskip \divide\@tempdima by 2
     \splittopskip=\topskip
  {\vbadness=\@M \loop \global\setbox3=\copy0
   \global\setbox1=\vsplit3 to \@tempdima
   \ifdim\ht3>\@tempdima \global\advance\@tempdima by 1pt \repeat}
   \setbox\@leftcolumn=\vbox to \@tempdima{\unvbox1\vfil}
   \setbox\@outputbox=\vbox to \@tempdima
     {\dimen2=\dp3\unvbox3\kern-\dimen2
      \vfil}
  \fi}
\newif\if@BAlanceone
\global\@BAlanceonefalse
\newdimen\oldvsize
\newcommand{\@BAdblcol}{\if@firstcolumn
       \unvbox\@outputbox \penalty\outputpenalty
       \global\oldvsize=\@colht \global\multiply \@colht by 2
       \global\@BAlanceonetrue
       \global\@firstcolumnfalse
  \else \global\@firstcolumntrue
       \if@BAlanceone
       \global\@BAlanceonefalse\@BAlancecol
       \global\@colht=\oldvsize \else
       \PackageWarningNoLine{balance}
          {You have called \protect\balance\space
             in second column\MessageBreak
           Columns might not be balanced}\fi
     \setbox\@outputbox\vbox to \@colht{\hbox to\textwidth
     {\hbox to\columnwidth {\box\@leftcolumn \hss}\hfil
      \vrule width\columnseprule\hfil \hbox to\columnwidth
      {\box\@outputbox \hss}}\vfil}\@combinedblfloats
     \@outputpage \begingroup \@dblfloatplacement
     \@startdblcolumn \@whilesw\if@fcolmade \fi
     {\@outputpage\@startdblcolumn}\endgroup
  \fi}
\newcommand{\@BAcleardblpage}{\clearpage\if@twoside \ifodd\c@page\else
  \hbox{}\newpage\fi\fi}
\newcommand{\@@cleardblpage}{}
\let\@@cleardblpage=\cleardoublepage

\newcommand{\@@utputdblcol}{}
\let\@@utputdblcol=\@outputdblcol
\newcommand{\balance}{\global\let\@outputdblcol=\@BAdblcol
  \global\let\cleardoublepage=\@BAcleardblpage}
\newcommand{\nobalance}{\global\let\@outputdblcol=\@@utputdblcol
  \global\let\cleardoublepage=\@@cleardblpage}
\endinput
%%
%% End of file `aguplus.cls'.
