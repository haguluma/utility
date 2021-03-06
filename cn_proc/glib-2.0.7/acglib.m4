## Portability defines that help interoperate with classic and modern autoconfs
ifdef([AC_TR_SH],[
define([GLIB_TR_SH],[AC_TR_SH([$1])])
define([GLIB_TR_CPP],[AC_TR_CPP([$1])])
], [
define([GLIB_TR_SH],
       [patsubst(translit([[$1]], [*+], [pp]), [[^a-zA-Z0-9_]], [_])])
define([GLIB_TR_CPP],
       [patsubst(translit([[$1]],
  	                  [*abcdefghijklmnopqrstuvwxyz],
 			  [PABCDEFGHIJKLMNOPQRSTUVWXYZ]),
		 [[^A-Z0-9_]], [_])])
])

# GLIB_AC_DIVERT_BEFORE_HELP(STUFF)
# ---------------------------------
# Put STUFF early enough so that they are available for $ac_help expansion.
# Handle both classic (<= v2.13) and modern autoconf
AC_DEFUN([GLIB_AC_DIVERT_BEFORE_HELP],
[ifdef([m4_divert_text], [m4_divert_text([NOTICE],[$1])],
       [ifdef([AC_DIVERT], [AC_DIVERT([NOTICE],[$1])],
              [AC_DIVERT_PUSH(AC_DIVERSION_NOTICE)dnl
$1
AC_DIVERT_POP()])])])

dnl GLIB_IF_VAR_EQ (ENV_VAR, VALUE [, EQUALS_ACTION] [, ELSE_ACTION])
AC_DEFUN(GLIB_IF_VAR_EQ,[
        case "$[$1]" in
        "[$2]"[)]
                [$3]
                ;;
        *[)]
                [$4]
                ;;
        esac
])
dnl GLIB_STR_CONTAINS (SRC_STRING, SUB_STRING [, CONTAINS_ACTION] [, ELSE_ACTION])
AC_DEFUN(GLIB_STR_CONTAINS,[
        case "[$1]" in
        *"[$2]"*[)]
                [$3]
                ;;
        *[)]
                [$4]
                ;;
        esac
])
dnl GLIB_ADD_TO_VAR (ENV_VARIABLE, CHECK_STRING, ADD_STRING)
AC_DEFUN(GLIB_ADD_TO_VAR,[
        GLIB_STR_CONTAINS($[$1], [$2], [$1]="$[$1]", [$1]="$[$1] [$3]")
])

dnl GLIB_SIZEOF (INCLUDES, TYPE, ALIAS [, CROSS-SIZE])
AC_DEFUN(GLIB_SIZEOF,
[pushdef([glib_Sizeof], GLIB_TR_SH([glib_cv_sizeof_$3]))dnl
AC_CACHE_CHECK([size of $2], glib_Sizeof,
[AC_TRY_RUN([#include <stdio.h>
#if STDC_HEADERS
#include <stdlib.h>
#include <stddef.h>
#endif
$1
main()
{
  FILE *f=fopen("conftestval", "w");
  if (!f) exit(1);
  fprintf(f, "%d\n", sizeof($2));
  exit(0);
}], 
  [glib_Sizeof=`cat conftestval`  dnl''
],
  [glib_Sizeof=0],
  ifelse([$4], [], [], [glib_Sizeof=$4]))])
AC_DEFINE_UNQUOTED(GLIB_TR_CPP(glib_sizeof_$3), [$[]glib_Sizeof], [Size of $3])
popdef([glib_Sizeof])dnl
])

dnl GLIB_BYTE_CONTENTS (INCLUDES, TYPE, ALIAS, N_BYTES, INITIALIZER)
AC_DEFUN(GLIB_BYTE_CONTENTS,
[pushdef([glib_ByteContents], GLIB_TR_SH([glib_cv_byte_contents_$3]))dnl
AC_CACHE_CHECK([byte contents of $5], glib_ByteContents,
[AC_TRY_RUN([#include <stdio.h>
$1
main()
{
  static $2 tv = $5;
  char *p = (char*) &tv;
  int i;
  FILE *f=fopen("conftestval", "w");
  if (!f) exit(1);
  for (i = 0; i < $4; i++)
    fprintf(f, "%s%d", i?",":"", *(p++));
  fprintf(f, "\n");
  exit(0);
}], 
   [glib_ByteContents=`cat conftestval`  dnl''
], 
   [glib_ByteContents=no],
   [glib_ByteContents=no])])
AC_DEFINE_UNQUOTED(GLIB_TR_CPP(glib_byte_contents_$3), [$[]glib_ByteContents],
	[Byte contents of $3])
popdef([glib_ByteContents])dnl
])

dnl GLIB_SYSDEFS (INCLUDES, DEFS_LIST, OFILE [, PREFIX])
AC_DEFUN(GLIB_SYSDEFS,
[glib_sysdefso="translit($3, [-_a-zA-Z0-9 *], [-_a-zA-Z0-9])"
glib_sysdef_msg=`echo $2 | sed 's/:[[^ 	]]*//g'`
if test "x`(echo '\n') 2>/dev/null`" != 'x\n'; then
  glib_nl='\\n'
else
  glib_nl='\n'
fi
AC_MSG_CHECKING(system definitions for $glib_sysdef_msg)
cat >confrun.c <<_______EOF
#include <stdio.h>
$1
int main (int c, char **v) {
  FILE *f = fopen ("$glib_sysdefso", "a");
  if (!f) return 1;
_______EOF
for glib_sysdef_input in $2 ; do
	glib_sysdef=`echo $glib_sysdef_input | sed 's/^\([[^:]]*\):.*$/\1/'`
	glib_default=`echo $glib_sysdef_input | sed 's/^[[^:]]*:\(.*\)$/\1/'`
	echo "#ifdef $glib_sysdef" >>confrun.c
	echo "  fprintf (f, \"#define GLIB_SYSDEF_%s %s%d${glib_nl}\", \"$glib_sysdef\", \"$4\", $glib_sysdef);" >>confrun.c
	echo "#else" >>confrun.c
	if test $glib_sysdef != $glib_default; then
		echo "  fprintf (f, \"#define GLIB_SYSDEF_%s %s%d${glib_nl}\", \"$glib_sysdef\", \"$4\", $glib_default);" >>confrun.c
	else
		echo "  fprintf (f, \"#define GLIB_SYSDEF_%s${glib_nl}\", \"$glib_sysdef\");" >>confrun.c
	fi
	echo "#endif" >>confrun.c
done
echo "return 0; }" >>confrun.c
AC_TRY_RUN(`cat confrun.c`, AC_MSG_RESULT(done),
[	for glib_sysdef_input in $2 ; do
		glib_sysdef=`echo $glib_sysdef_input | sed 's/^\([[^:]]*\):.*$/\1/'`
		glib_default=`echo $glib_sysdef_input | sed 's/^[[^:]]*:\(.*\)$/\1/'`
		if test $glib_sysdef != $glib_default; then
			glib_default=" $4$glib_default"
		else
			glib_default=
		fi
		echo "#define GLIB_SYSDEF_$glib_sysdef$glib_default" >>$glib_sysdefso
	done
	AC_MSG_RESULT(failed)])
rm -f confrun.c
])

# GLIB_CHECK_COMPILE_WARNINGS(PROGRAM, [ACTION-IF-FOUND], [ACTION-IF-NOT-FOUND])
# ---------------------------------------------------------------------
# Try to compile PROGRAM, check for warnings
m4_define([GLIB_CHECK_COMPILE_WARNINGS],
[m4_ifvaln([$1], [AC_LANG_CONFTEST([$1])])dnl
rm -f conftest.$ac_objext
glib_ac_compile_save="$ac_compile"
ac_compile='$CC -c $CFLAGS $CPPFLAGS conftest.$ac_ext'
AS_IF([_AC_EVAL_STDERR($ac_compile) &&
         AC_TRY_COMMAND([(if test -s conftest.err; then false ; else true; fi)])],
      [$2],
      [echo "$as_me: failed program was:" >&AS_MESSAGE_LOG_FD
cat conftest.$ac_ext >&AS_MESSAGE_LOG_FD
m4_ifvaln([$3],[$3])dnl])dnl
ac_compile="$glib_ac_compile_save"
rm -f conftest.$ac_objext conftest.err m4_ifval([$1], [conftest.$ac_ext])[]dnl
])# GLIB_CHECK_COMPILE_WARNINGS
