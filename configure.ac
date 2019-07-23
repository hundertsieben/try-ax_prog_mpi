AC_INIT([try-ax_prog_mpi], [1.0], [thomas_lynn.marcus@tu-dresden.de])
AM_INIT_AUTOMAKE([-Wall -Werror])

dnl AC_CONFIG_AUXDIR([build-aux]

AC_DEFUN_ONCE([TA_PROG_CC_MPI],[
# MPI1_
AX_PROG_CC_MPI
# MPI3_
AC_SUBST(MPILIBS)
# MPI4_
])

TA_PROG_CC_MPI

AC_CHECK_HEADERS([inttypes.h])
AC_CHECK_HEADERS([stdlib.h])
AC_CHECK_HEADERS([string.h])
AC_CONFIG_HEADERS([config.h])

AC_CONFIG_FILES([
    Makefile
    ])

AC_SUBST(CFLAGS)
AC_SUBST(CXXFLAGS)
AC_SUBST(LDFLAGS)
AC_SUBST(DEBUG)

AC_OUTPUT
