AC_INIT([try-ax_prog_mpi], [1.0], [thomas_lynn.marcus@tu-dresden.de])
AM_INIT_AUTOMAKE([-Wall -Werror])

dnl AC_CONFIG_AUXDIR([build-aux]

# ----- TA_WITH_LIB ------------------------------
m4_define([TA_WITH_LIB],[
  # define local scope variables
  m4_define(TA_FULLNAME, $1)
  m4_define(TA_LOWERNAME, m4_translit(TA_FULLNAME, [A-Z], [a-z]))
  m4_define(TA_UPPERNAME, m4_translit(TA_FULLNAME, [a-z], [A-Z]))
  m4_define(TA_FUNC, $2)
  m4_define(TA_LIB, $3)
  m4_define(TA_EXTRA_CODE, $4)
  m4_define(TA_EXTRA_FLAGS, $5)

  AC_ARG_WITH(TA_LOWERNAME,
    AS_HELP_STRING([--without-]TA_LOWERNAME, [Ignore presence of ]TA_FULLNAME[ solver and disable it]))

  # force value $with_solver for all solvers if --with-all-solvers
  AS_IF([test "x$with_all_solvers" = "xyes"],
      [with_]TA_LOWERNAME[=yes],
      [test "x$with_all_solvers" = "xno"],
      [with_]TA_LOWERNAME[=no]
      )
  
  # execute extra code if the library is wanted
  AS_IF(
    [test "x$with_]TA_LOWERNAME[" != "xyes"],
    [TA_EXTRA_CODE]
  )
  
  # set $have_ variables
  AS_IF(
    [test "x$with_]TA_LOWERNAME[" != "xno"],    
    [AC_SEARCH_LIBS(]TA_FUNC[,]TA_LIB[,have_]TA_LOWERNAME[=yes,have_]TA_LOWERNAME[=no,]TA_EXTRA_FLAGS[)],
    [have_]TA_LOWERNAME[=no TA_MSG_CHECKING(for library containing ]TA_FUNC[) AC_MSG_RESULT(<skipped>)]
  )

  # if its found, then all good
  # if it wasn't found and it was required, then error
  AS_IF(
    [test "x$have_]TA_LOWERNAME[" = "xyes"],
    [AC_DEFINE(HAVE_]TA_UPPERNAME[,1,]TA_FULLNAME[ solver is available)],
    [test "x$with_]TA_LOWERNAME[" = "xyes"],
    [AC_MSG_ERROR(]TA_FULLNAME[ solver requested but not found)]
  )

  # check if the variables were set correctly
  AM_CONDITIONAL(
    [HAVE_]TA_UPPERNAME,
    [test "x$have_]TA_LOWERNAME[" = "xyes"]
  )
  
  # substitute variable
  AC_SUBST([have_]TA_LOWERNAME)

  # undefine local scope variables
  m4_undefine([TA_FULLNAME])
  m4_undefine([TA_LOWERNAME])
  m4_undefine([TA_UPPERNAME])
  m4_undefine([TA_FUNC])
  m4_undefine([TA_LIB])
  m4_undefine([TA_EXTRA_CODE])
  m4_undefine([TA_EXTRA_FLAGS])
])
# -----END TA_WITH_LIB ------------------------------

AC_DEFUN_ONCE([TA_PROG_CC_MPI],[
# MPI1_
AX_PROG_CC_MPI
# MPI2_
])

TA_WITH_LIB([MUMPS], [dmumps_c], [dmumps], [TA_PROG_CC_MPI])

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
