%-----------------------------------------------------------------------------
%
%               LaTeX Class/Style File
%
% Name:         sigplanconf.cls
% Purpose:      A LaTeX 2e class file for SIGPLAN conference proceedings.
%               This class file supercedes acm_proc_article-sp,
%               sig-alternate, and sigplan-proc.
%
% Author:       Paul C. Anagnostopoulos
%               Windfall Software
%               978 371-2316
%               paul@windfall.com
%
% Created:      12 September 2004
%
% Revisions:    See end of file.
%
%-----------------------------------------------------------------------------


\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{sigplanconf}[2007/03/13 v1.5 ACM SIGPLAN Proceedings]

% The following few pages contain LaTeX programming extensions adapted
% from the ZzTeX macro package.

%                       Token Hackery
%                       ----- -------


\def \@expandaftertwice {\expandafter\expandafter\expandafter}
\def \@expandafterthrice {\expandafter\expandafter\expandafter\expandafter
                          \expandafter\expandafter\expandafter}

% This macro discards the next token.

\def \@discardtok #1{}%                                  token

% This macro removes the `pt' following a dimension.

{\catcode `\p = 12 \catcode `\t = 12

\gdef \@remover #1pt{#1}

} % \catcode

% This macro extracts the contents of a macro and returns it as plain text.
% Usage: \expandafter\@defof \meaning\macro\@mark

\def \@defof #1:->#2\@mark{#2}

%                       Control Sequence Names
%                       ------- -------- -----


\def \@name #1{%                                        {\tokens}
  \csname \expandafter\@discardtok \string#1\endcsname}

\def \@withname #1#2{%                                  {\command}{\tokens}
  \expandafter#1\csname \expandafter\@discardtok \string#2\endcsname}

%                       Flags (Booleans)
%                       ----- ----------

% The boolean literals \@true and \@false are appropriate for use with
% the \if command, which tests the codes of the next two characters.

\def \@true {TT}
\def \@false {FL}

\def \@setflag #1=#2{\edef #1{#2}}%              \flag = boolean

%                       IF and Predicates
%                       -- --- ----------

% A "predicate" is a macro that returns \@true or \@false as its value.
% Such values are suitable for use with the \if conditional.  For example:
%
%   \if \@oddp{\x} <then-clause> \else <else-clause> \fi

% A predicate can be used with \@setflag as follows:
%
%   \@setflag \flag = {<predicate>}

% Here are the predicates for TeX's repertoire of conditional
% commands.  These might be more appropriately interspersed with
% other definitions in this module, but what the heck.
% Some additional "obvious" predicates are defined.

\def \@eqlp   #1#2{\ifnum #1 = #2\@true \else \@false \fi}
\def \@neqlp  #1#2{\ifnum #1 = #2\@false \else \@true \fi}
\def \@lssp   #1#2{\ifnum #1 < #2\@true \else \@false \fi}
\def \@gtrp   #1#2{\ifnum #1 > #2\@true \else \@false \fi}
\def \@zerop  #1{\ifnum #1 = 0\@true \else \@false \fi}
\def \@onep   #1{\ifnum #1 = 1\@true \else \@false \fi}
\def \@posp   #1{\ifnum #1 > 0\@true \else \@false \fi}
\def \@negp   #1{\ifnum #1 < 0\@true \else \@false \fi}
\def \@oddp   #1{\ifodd #1\@true \else \@false \fi}
\def \@evenp  #1{\ifodd #1\@false \else \@true \fi}
\def \@rangep #1#2#3{\if \@orp{\@lssp{#1}{#2}}{\@gtrp{#1}{#3}}\@false \else
                                                          \@true \fi}
\def \@tensp  #1{\@rangep{#1}{10}{19}}

\def \@dimeqlp   #1#2{\ifdim #1 = #2\@true \else \@false \fi}
\def \@dimneqlp  #1#2{\ifdim #1 = #2\@false \else \@true \fi}
\def \@dimlssp   #1#2{\ifdim #1 < #2\@true \else \@false \fi}
\def \@dimgtrp   #1#2{\ifdim #1 > #2\@true \else \@false \fi}
\def \@dimzerop  #1{\ifdim #1 = 0pt\@true \else \@false \fi}
\def \@dimposp   #1{\ifdim #1 > 0pt\@true \else \@false \fi}
\def \@dimnegp   #1{\ifdim #1 < 0pt\@true \else \@false \fi}

\def \@vmodep     {\ifvmode \@true \else \@false \fi}
\def \@hmodep     {\ifhmode \@true \else \@false \fi}
\def \@mathmodep  {\ifmmode \@true \else \@false \fi}
\def \@textmodep  {\ifmmode \@false \else \@true \fi}
\def \@innermodep {\ifinner \@true \else \@false \fi}

\long\def \@codeeqlp #1#2{\if #1#2\@true \else \@false \fi}

\long\def \@cateqlp #1#2{\ifcat #1#2\@true \else \@false \fi}

\long\def \@tokeqlp  #1#2{\ifx #1#2\@true \else \@false \fi}
\long\def \@xtokeqlp #1#2{\expandafter\ifx #1#2\@true \else \@false \fi}

\long\def \@definedp #1{%
  \expandafter\ifx \csname \expandafter\@discardtok \string#1\endcsname
                   \relax \@false \else \@true \fi}

\long\def \@undefinedp #1{%
  \expandafter\ifx \csname \expandafter\@discardtok \string#1\endcsname
                   \relax \@true \else \@false \fi}

\def \@emptydefp #1{\ifx #1\@empty \@true \else \@false \fi}%       {\name}

\let \@emptylistp = \@emptydefp

\long\def \@emptyargp #1{%                               {#n}
  \@empargp #1\@empargq\@mark}
\long\def \@empargp #1#2\@mark{%
  \ifx #1\@empargq \@true \else \@false \fi}
\def \@empargq {\@empargq}

\def \@emptytoksp #1{%                                   {\tokenreg}
  \expandafter\@emptoksp \the#1\@mark}

\long\def \@emptoksp #1\@mark{\@emptyargp{#1}}

\def \@voidboxp #1{\ifvoid #1\@true \else \@false \fi}
\def \@hboxp #1{\ifhbox #1\@true \else \@false \fi}
\def \@vboxp #1{\ifvbox #1\@true \else \@false \fi}

\def \@eofp #1{\ifeof #1\@true \else \@false \fi}


% Flags can also be used as predicates, as in:
%
%   \if \flaga <then-clause> \else <else-clause> \fi


% Now here we have predicates for the common logical operators.

\def \@notp #1{\if #1\@false \else \@true \fi}

\def \@andp #1#2{\if #1%
                  \if #2\@true \else \@false \fi
                \else
                  \@false
                \fi}

\def \@orp #1#2{\if #1%
                 \@true
               \else
                 \if #2\@true \else \@false \fi
               \fi}

\def \@xorp #1#2{\if #1%
                  \if #2\@false \else \@true \fi
                \else
                  \if #2\@true \else \@false \fi
                \fi}

%                       Arithmetic
%                       ----------

\def \@increment #1{\advance #1 by 1\relax}%             {\count}

\def \@decrement #1{\advance #1 by -1\relax}%            {\count}

%                       Options
%                       -------


\@setflag \@blockstyle = \@false
\@setflag \@copyrightwanted = \@true
\@setflag \@explicitsize = \@false
\@setflag \@mathtime = \@false
\@setflag \@natbib = \@false
\@setflag \@ninepoint = \@true
\newcount{\@numheaddepth} \@numheaddepth = 3
\@setflag \@onecolumn = \@false
\@setflag \@preprint = \@false
\@setflag \@reprint = \@false
\@setflag \@tenpoint = \@false
\@setflag \@times = \@false

% Note that all the dangerous article class options are trapped.

\DeclareOption{9pt}{\@setflag \@ninepoint = \@true
                    \@setflag \@explicitsize = \@true}

\DeclareOption{10pt}{\PassOptionsToClass{10pt}{article}%
                     \@setflag \@ninepoint = \@false
                     \@setflag \@tenpoint = \@true
                     \@setflag \@explicitsize = \@true}

\DeclareOption{11pt}{\PassOptionsToClass{11pt}{article}%
                     \@setflag \@ninepoint = \@false
                     \@setflag \@explicitsize = \@true}

\DeclareOption{12pt}{\@unsupportedoption{12pt}}

\DeclareOption{a4paper}{\@unsupportedoption{a4paper}}

\DeclareOption{a5paper}{\@unsupportedoption{a5paper}}

\DeclareOption{b5paper}{\@unsupportedoption{b5paper}}

\DeclareOption{blockstyle}{\@setflag \@blockstyle = \@true}

\DeclareOption{cm}{\@setflag \@times = \@false}

\DeclareOption{computermodern}{\@setflag \@times = \@false}

\DeclareOption{executivepaper}{\@unsupportedoption{executivepaper}}

\DeclareOption{indentedstyle}{\@setflag \@blockstyle = \@false}

\DeclareOption{landscape}{\@unsupportedoption{landscape}}

\DeclareOption{legalpaper}{\@unsupportedoption{legalpaper}}

\DeclareOption{letterpaper}{\@unsupportedoption{letterpaper}}

\DeclareOption{mathtime}{\@setflag \@mathtime = \@true}

\DeclareOption{natbib}{\@setflag \@natbib = \@true}

\DeclareOption{nocopyrightspace}{\@setflag \@copyrightwanted = \@false}

\DeclareOption{notitlepage}{\@unsupportedoption{notitlepage}}

\DeclareOption{numberedpars}{\@numheaddepth = 4}

%%%\DeclareOption{onecolumn}{\@setflag \@onecolumn = \@true}

\DeclareOption{preprint}{\@setflag \@preprint = \@true}

\DeclareOption{reprint}{\@setflag \@reprint = \@true}

\DeclareOption{times}{\@setflag \@times = \@true}

\DeclareOption{titlepage}{\@unsupportedoption{titlepage}}

\DeclareOption{twocolumn}{\@setflag \@onecolumn = \@false}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ExecuteOptions{9pt,indentedstyle,times}
\@setflag \@explicitsize = \@false
\ProcessOptions

\if \@onecolumn
  \if \@notp{\@explicitsize}%
    \@setflag \@ninepoint = \@false
    \PassOptionsToClass{11pt}{article}%
  \fi
  \PassOptionsToClass{twoside,onecolumn}{article}
\else
  \PassOptionsToClass{twoside,twocolumn}{article}
\fi
\LoadClass{article}

\def \@unsupportedoption #1{%
  \ClassError{proc}{The standard '#1' option is not supported.}}

% This can be used with the 'reprint' option to get the final folios.

\def \setpagenumber #1{%
  \setcounter{page}{#1}}

\AtEndDocument{\label{sigplanconf@finalpage}}

%                       Utilities
%                       ---------


\newcommand{\setvspace}[2]{%
  #1 = #2
  \advance #1 by -1\parskip}

%                       Document Parameters
%                       -------- ----------


% Page:

\setlength{\hoffset}{-1in}
\setlength{\voffset}{-1in}

\setlength{\topmargin}{1in}
\setlength{\headheight}{0pt}
\setlength{\headsep}{0pt}

\if \@onecolumn
  \setlength{\evensidemargin}{.75in}
  \setlength{\oddsidemargin}{.75in}
\else
  \setlength{\evensidemargin}{.75in}
  \setlength{\oddsidemargin}{.75in}
\fi

% Text area:

\newdimen{\standardtextwidth}
\setlength{\standardtextwidth}{42pc}

\if \@onecolumn
  \setlength{\textwidth}{40.5pc}
\else
  \setlength{\textwidth}{\standardtextwidth}
\fi

\setlength{\topskip}{8pt}
\setlength{\columnsep}{2pc}
\setlength{\textheight}{54.5pc}

% Running foot:

\setlength{\footskip}{30pt}

% Paragraphs:

\if \@blockstyle
  \setlength{\parskip}{5pt plus .1pt minus .5pt}
  \setlength{\parindent}{0pt}
\else
  \setlength{\parskip}{0pt}
  \setlength{\parindent}{12pt}
\fi

\setlength{\lineskip}{.5pt}
\setlength{\lineskiplimit}{\lineskip}

\frenchspacing
\pretolerance = 400
\tolerance = \pretolerance
\setlength{\emergencystretch}{5pt}
\clubpenalty = 10000
\widowpenalty = 10000
\setlength{\hfuzz}{.5pt}

% Standard vertical spaces:

\newskip{\standardvspace}
\setvspace{\standardvspace}{5pt plus 1pt minus .5pt}

% Margin paragraphs:

\setlength{\marginparwidth}{36pt}
\setlength{\marginparsep}{2pt}
\setlength{\marginparpush}{8pt}


\setlength{\skip\footins}{8pt plus 3pt minus 1pt}
\setlength{\footnotesep}{9pt}

\renewcommand{\footnoterule}{%
  \hrule width .5\columnwidth height .33pt depth 0pt}

\renewcommand{\@makefntext}[1]{%
  \noindent \@makefnmark \hspace{1pt}#1}

% Floats:

\setcounter{topnumber}{4}
\setcounter{bottomnumber}{1}
\setcounter{totalnumber}{4}

\renewcommand{\fps@figure}{tp}
\renewcommand{\fps@table}{tp}
\renewcommand{\topfraction}{0.90}
\renewcommand{\bottomfraction}{0.30}
\renewcommand{\textfraction}{0.10}
\renewcommand{\floatpagefraction}{0.75}

\setcounter{dbltopnumber}{4}

\renewcommand{\dbltopfraction}{\topfraction}
\renewcommand{\dblfloatpagefraction}{\floatpagefraction}

\setlength{\floatsep}{18pt plus 4pt minus 2pt}
\setlength{\textfloatsep}{18pt plus 4pt minus 3pt}
\setlength{\intextsep}{10pt plus 4pt minus 3pt}

\setlength{\dblfloatsep}{18pt plus 4pt minus 2pt}
\setlength{\dbltextfloatsep}{20pt plus 4pt minus 3pt}

% Miscellaneous:

\errorcontextlines = 5

%                       Fonts
%                       -----


\if \@times
  \renewcommand{\rmdefault}{ptm}%
  \if \@mathtime
    \usepackage[mtbold,noTS1]{mathtime}%
  \else
%%%    \usepackage{mathptm}%
  \fi
\else
  \relax
\fi

\if \@ninepoint

\renewcommand{\normalsize}{%
  \@setfontsize{\normalsize}{9pt}{10pt}%
  \setlength{\abovedisplayskip}{5pt plus 1pt minus .5pt}%
  \setlength{\belowdisplayskip}{\abovedisplayskip}%
  \setlength{\abovedisplayshortskip}{3pt plus 1pt minus 2pt}%
  \setlength{\belowdisplayshortskip}{\abovedisplayshortskip}}

\renewcommand{\tiny}{\@setfontsize{\tiny}{5pt}{6pt}}

\renewcommand{\scriptsize}{\@setfontsize{\scriptsize}{7pt}{8pt}}

\renewcommand{\small}{%
  \@setfontsize{\small}{8pt}{9pt}%
  \setlength{\abovedisplayskip}{4pt plus 1pt minus 1pt}%
  \setlength{\belowdisplayskip}{\abovedisplayskip}%
  \setlength{\abovedisplayshortskip}{2pt plus 1pt}%
  \setlength{\belowdisplayshortskip}{\abovedisplayshortskip}}

\renewcommand{\footnotesize}{%
  \@setfontsize{\footnotesize}{8pt}{9pt}%
  \setlength{\abovedisplayskip}{4pt plus 1pt minus .5pt}%
  \setlength{\belowdisplayskip}{\abovedisplayskip}%
  \setlength{\abovedisplayshortskip}{2pt plus 1pt}%
  \setlength{\belowdisplayshortskip}{\abovedisplayshortskip}}

\renewcommand{\large}{\@setfontsize{\large}{11pt}{13pt}}

\renewcommand{\Large}{\@setfontsize{\Large}{14pt}{18pt}}

\renewcommand{\LARGE}{\@setfontsize{\LARGE}{18pt}{20pt}}

\renewcommand{\huge}{\@setfontsize{\huge}{20pt}{25pt}}

\renewcommand{\Huge}{\@setfontsize{\Huge}{25pt}{30pt}}

\else\if \@tenpoint

\relax

\else

\relax

\fi\fi

%                       Abstract
%                       --------


\renewenvironment{abstract}{%
  \section*{Abstract}%
  \normalsize}{%
  }

%                       Bibliography
%                       ------------


\renewenvironment{thebibliography}[1]
     {\section*{\refname
        \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \bibfont
      \softraggedright%%%\sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}

\if \@natbib

\usepackage{natbib}
\setlength{\bibsep}{3pt plus .5pt minus .25pt}
\bibpunct{(}{)}{;}{A}{}{,}
\let \cite = \citep

\fi

\def \bibfont {\small}

%                       Categories
%                       ----------


\@setflag \@firstcategory = \@true

\newcommand{\category}[3]{%
  \if \@firstcategory
    \paragraph*{Categories and Subject Descriptors}%
    \@setflag \@firstcategory = \@false
  \else
    \unskip ;\hspace{.75em}%
  \fi
  \@ifnextchar [{\@category{#1}{#2}{#3}}{\@category{#1}{#2}{#3}[]}}

\def \@category #1#2#3[#4]{%
  {\let \and = \relax
   #1 [\textit{#2}]%
   \if \@emptyargp{#4}%
     \if \@notp{\@emptyargp{#3}}: #3\fi
   \else
     :\space
     \if \@notp{\@emptyargp{#3}}#3---\fi
     \textrm{#4}%
   \fi}}

%                       Copyright Notice
%                       --------- ------


\def \ftype@copyrightbox {8}
\def \@toappear {}
\def \@permission {}


\def \@copyrightspace {%
  \@float{copyrightbox}[b]%
  \vbox to 1in{%
    \vfill
    \parbox[b]{20pc}{%
      \scriptsize
      \if \@preprint
        [Copyright notice will appear here
         once 'preprint' option is removed.]\par
      \else
        \@toappear
      \fi
      \if \@reprint
        \noindent Reprinted from \@conferencename,
        \@proceedings,
        \@conferenceinfo,
        pp.~\number\thepage--\pageref{sigplanconf@finalpage}.\par
      \fi}}%
  \end@float}

\long\def \toappear #1{%
  \def \@toappear {#1}}

\toappear{%
  \noindent \@permission \par
  \vspace{2pt}
  \noindent \textsl{\@conferencename}\quad \@conferenceinfo \par
  \noindent Copyright \copyright\ \@copyrightyear\ ACM \@copyrightdata
    \dots \$5.00\par}

\newcommand{\permission}[1]{%
  \gdef \@permission {#1}}

\permission{%
  Permission to make digital or hard copies of all or
  part of this work for personal or classroom use is granted without
  fee provided that copies are not made or distributed for profit or
  commercial advantage and that copies bear this notice and the full
  citation on the first page.  To copy otherwise, to republish, to
  post on servers or to redistribute to lists, requires prior specific
  permission and/or a fee.}

% Here we have some alternate permission statements and copyright lines:

\newcommand{\ACMCanadapermission}{%
  \permission{%
    Copyright \@copyrightyear\ Association for Computing Machinery.
    ACM acknowledges that
    this contribution was authored or co-authored by an affiliate of the
    National Research Council of Canada (NRC).
    As such, the Crown in Right of
    Canada retains an equal interest in the copyright, however granting
    nonexclusive, royalty-free right to publish or reproduce this article,
    or to allow others to do so, provided that clear attribution
    is also given to the authors and the NRC.}}

\newcommand{\ACMUSpermission}{%
  \permission{%
    Copyright \@copyrightyear\ Association for
    Computing Machinery. ACM acknowledges that
    this contribution was authored or co-authored
    by a contractor or affiliate
    of the U.S. Government. As such, the Government retains a nonexclusive,
    royalty-free right to publish or reproduce this article,
    or to allow others to do so, for Government purposes only.}}

\newcommand{\authorpermission}{%
  \permission{%
    Copyright is held by the author/owner(s).}
  \toappear{%
    \noindent \@permission \par
    \vspace{2pt}
    \noindent \textsl{\@conferencename}\quad \@conferenceinfo \par
    ACM \@copyrightdata.}}

\newcommand{\Sunpermission}{%
  \permission{%
    Copyright is held by Sun Microsystems, Inc.}%
  \toappear{%
    \noindent \@perm