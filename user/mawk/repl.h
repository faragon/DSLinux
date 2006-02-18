
/********************************************
repl.h
copyright 1991, Michael D. Brennan

This is a source file for mawk, an implementation of
the AWK programming language.

Mawk is distributed without warranty under the terms of
the GNU General Public License, version 2, 1991.
********************************************/

/*$Log$
 *Revision 1.1.2.1  2006/02/18 16:47:47  stsp2
 *adding uClinux-dist CVS snapshot from 2005-10-14
 *
 * Revision 1.1.1.1  1993/07/03  18:58:19  mike
 * move source to cvs
 *
 * Revision 5.1  1991/12/05  07:59:32  brennan
 * 1.1 pre-release
 *
*/

/* repl.h */

#ifndef  REPL_H
#define  REPL_H

PTR  PROTO( re_compile, (STRING *) ) ;
char *PROTO( re_uncompile, (PTR) ) ;


CELL *PROTO( repl_compile, (STRING *) ) ;
char *PROTO( repl_uncompile, (CELL *) ) ;
void  PROTO( repl_destroy, (CELL *) ) ;
CELL *PROTO( replv_cpy, (CELL *, CELL *) ) ;
CELL *PROTO( replv_to_repl, (CELL *, STRING *) ) ;

#endif
