CauseWay Tools Package 1 Version 1.0a Documentation
===================================================

The CauseWay Tools Package 1 contains three useful routines for
programmers using the CauseWay for Clipper 5 package, including
commented assembly language source.  Although they are generally
self-documenting (standard weasel words to avoid having to
create a large READ.ME file), following is a short overview of
what is provided.  But first, the generic legal blurboid:

All source code contained in CauseWay Tools Package 1,
consisting of the files FILEVIEW.ASM, GETENV.ASM, and
SETENV2.ASM, is hereby released to public domain.  Michael
Devore grants no warranties, express or implied, regarding the
CauseWay Tools Package 1's fitness for any application, use, or
purpose.  Use of these routines is strictly at your own risk and
pleasure.

The showcase of CauseWay Tools Package 1 is the 100% assembly
language file viewer, written by Ted Means.  This nifty utility
allows viewing ASCII files up to 4G in size via a
Clipper-callable routine.  You can control many of the display
aspects of the file viewed, via keystrokes or other mechanisms.

A small example PRG, called CWFVDEMO.PRG that demonstrates use
of the file viewer is included.  Simply compile it with
Clipper's /n option and then pass the file name you wish to view
on the command line.

SETENV2.ASM is a version of the public domain SETENV.ASM by
Kevin Saffer modified by Michael Devore to work in protected
mode.  SETE will add variables to the DOS master environment
table.

GETENV.ASM is a small routine written by Michael Devore which
behaves the same as Clipper's internal GETENV routine.  This
version, however, does not fail, disapprove, or act
inappropriately if an environment variable, such as PATH,
exceeds 127 characters.

GETENV does NOT change the case of the passed string, so you can
search for lowercase environment variables (settable by some
utilities including the free WarpWrap environment variable
burn-in utility) without problems.  Remember, if you pass a
lowercase environment variable to GETENV, it will not match the
uppercase equivalent.

Note that linking in GETENV.OBJ probably will cause a duplicate
symbol warning because the Clipper module which defines GETENV
also defines GETE, meaning that the module still gets linked in.
If you find this particularly bothersome, you can modify
GETENV.ASM to publicly list GETE as an additional entry point
(currently that's all Clipper does anyway, force GETE to call
GETENV).

Any questions, comments, bug reports, or feature enhancements,
please direct them to Michael Devore [71540,62].  I will forward
on any file viewer comments more appropriate for Ted's
examination.

If there are other public domain with source tools you would
like to see, drop us a line.

Fixes and Modifications
=======================

7/24/95 - Corrected error in FILEVIEW.ASM.  Wasn't working
correctly when not under a full screen, i.e. when screen
coordinates didn't start at 0,0.
