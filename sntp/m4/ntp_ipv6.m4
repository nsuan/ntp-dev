dnl ######################################################################
dnl Common IPv6 detection for NTP configure.ac files
AC_DEFUN([NTP_IPV6], [


AC_CACHE_CHECK(
    [for struct sockaddr_storage],
    [ntp_cv_sockaddr_storage],
    [AC_COMPILE_IFELSE(
	[AC_LANG_PROGRAM(
	    [[
		#ifdef HAVE_SYS_TYPES_H
		# include <sys/types.h>
		#endif
		#ifdef HAVE_SYS_SOCKET_H
		# include <sys/socket.h>
		#endif
		#ifdef HAVE_NETINET_IN_H
		# include <netinet/in.h>
		#endif
	    ]],
	    [[
		struct sockaddr_storage n;
	    ]]
	)],
	[ntp_cv_sockaddr_storage=yes],
	[ntp_cv_sockaddr_storage=no]
    )]
)
case "$ntp_cv_sockaddr_storage" in
 yes)
    AC_DEFINE([HAVE_STRUCT_SOCKADDR_STORAGE], [1],
	[Does a system header define struct sockaddr_storage?])
esac

AC_CACHE_CHECK(
    [for sockaddr_storage.ss_family],
    [ntp_cv_have_ss_family],
    [AC_COMPILE_IFELSE(
	[AC_LANG_PROGRAM(
	    [[
		#ifdef HAVE_SYS_TYPES_H
		# include <sys/types.h>
		#endif
		#ifdef HAVE_SYS_SOCKET_H
		# include <sys/socket.h>
		#endif
		#ifdef HAVE_NETINET_IN_H
		# include <netinet/in.h>
		#endif
	    ]],
	    [[
		struct sockaddr_storage s;
		s.ss_family = 1;
	    ]]
	)],
	[ntp_cv_have_ss_family=yes],
	[ntp_cv_have_ss_family=no]
    )]
)

case "$ntp_cv_have_ss_family" in
 no)
    AC_CACHE_CHECK(
	[for sockaddr_storage.__ss_family],
	[ntp_cv_have___ss_family],
	[AC_COMPILE_IFELSE(
	    [AC_LANG_PROGRAM(
		[[
		    #ifdef HAVE_SYS_TYPES_H
		    # include <sys/types.h>
		    #endif
		    #ifdef HAVE_SYS_SOCKET_H
		    # include <sys/socket.h>
		    #endif
		    #ifdef HAVE_NETINET_IN_H
		    # include <netinet/in.h>
		    #endif
		]],
		[[
		    struct sockaddr_storage s;
		    s.__ss_family = 1;
		]]
	    )],
	    [ntp_cv_have___ss_family=yes],
	    [ntp_cv_have___ss_family=no]
	)]
    )
    case "$ntp_cv_have___ss_family" in
     yes)
	AC_DEFINE([HAVE___SS_FAMILY_IN_SS], [1],
	    [Does struct sockaddr_storage have __ss_family?])
    esac
    ;;
esac

AH_VERBATIM(
    [HAVE___SS_FAMILY_IN_SS_VERBATIM],
    [
	/* Handle sockaddr_storage.__ss_family */
	#ifdef HAVE___SS_FAMILY_IN_SS
	# define ss_family __ss_family
	#endif /* HAVE___SS_FAMILY_IN_SS */
    ]
)

AC_CACHE_CHECK(
    [for sockaddr_storage.ss_len],
    [ntp_cv_have_ss_len],
    [AC_COMPILE_IFELSE(
	[AC_LANG_PROGRAM(
	    [[
		#ifdef HAVE_SYS_TYPES_H
		# include <sys/types.h>
		#endif
		#ifdef HAVE_SYS_SOCKET_H
		# include <sys/socket.h>
		#endif
		#ifdef HAVE_NETINET_IN_H
		# include <netinet/in.h>
		#endif
	    ]],
	    [[
		struct sockaddr_storage s;
		s.ss_len = 1;
	    ]]
	)],
	[ntp_cv_have_ss_len=yes],
	[ntp_cv_have_ss_len=no]
    )]
)

case "$ntp_cv_have_ss_len" in
 no)
    AC_CACHE_CHECK(
	[for sockaddr_storage.__ss_len],
	[ntp_cv_have___ss_len],
	[AC_COMPILE_IFELSE(
	    [AC_LANG_PROGRAM(
		[[
		    #ifdef HAVE_SYS_TYPES_H
		    # include <sys/types.h>
		    #endif
		    #ifdef HAVE_SYS_SOCKET_H
		    # include <sys/socket.h>
		    #endif
		    #ifdef HAVE_NETINET_IN_H
		    # include <netinet/in.h>
		    #endif
		]],
		[[
		    struct sockaddr_storage s;
		    s.__ss_len = 1;
		]]
	    )],
	    [ntp_cv_have___ss_len=yes],
	    [ntp_cv_have___ss_len=no]
	)]
    )
    case "$ntp_cv_have___ss_len" in
     yes)
	AC_DEFINE([HAVE___SS_LEN_IN_SS], [1],
	    [Does struct sockaddr_storage have __ss_len?])
    esac
    ;;
esac

AH_VERBATIM(
    [HAVE___SS_LEN_IN_SS_VERBATIM],
    [
	/* Handle sockaddr_storage.__ss_len */
	#ifdef HAVE___SS_LEN_IN_SS
	# define ss_len __ss_len
	#endif /* HAVE___SS_LEN_IN_SS */
    ]
)

#
# Look for in_port_t.
#
AC_CACHE_CHECK(
    [for in_port_t],
    [isc_cv_have_in_port_t],
    [AC_COMPILE_IFELSE(
	[AC_LANG_PROGRAM(
	    [[
		#include <sys/types.h>
		#include <netinet/in.h>
	    ]],
	    [[
		in_port_t port = 25; 
		return (0);
	    ]]
	)],
	[isc_cv_have_in_port_t=yes],
	[isc_cv_have_in_port_t=no]
    )]
)
case "$isc_cv_have_in_port_t" in
 no)
	AC_DEFINE([ISC_PLATFORM_NEEDPORTT], [1],
	    [Declare in_port_t?])
esac

AC_CACHE_CHECK(
    [type of socklen arg for getsockname()],
    [ntp_cv_getsockname_socklen_type],
    [
    getsockname_socklen_type_found=no
    for getsockname_arg2 in 'struct sockaddr *' 'void *'; do
	for ntp_cv_getsockname_socklen_type in 'socklen_t' 'size_t' 'unsigned int' 'int'; do
	    AC_COMPILE_IFELSE(
		[AC_LANG_PROGRAM(
		    [[
			#ifdef HAVE_SYS_TYPES_H
			# include <sys/types.h>
			#endif
			#ifdef HAVE_SYS_SOCKET_H
			# include <sys/socket.h>
			#endif
		    ]], [[
			extern
			getsockname(int, $getsockname_arg2, 
				$ntp_cv_getsockname_socklen_type *);
		    ]]
		)],
		[getsockname_socklen_type_found=yes ; break 2],
		[]
	    )
	done
    done
    case "$getsockname_socklen_type_found" in
     no)
	ntp_cv_getsockname_socklen_type='socklen_t'
    esac
    AS_UNSET([getsockname_arg2])
    AS_UNSET([getsockname_socklen_type_found])
    ]
)
AC_DEFINE_UNQUOTED([GETSOCKNAME_SOCKLEN_TYPE],
		   [$ntp_cv_getsockname_socklen_type],
		   [What is getsockname()'s socklen type?])

AC_CACHE_CHECK(
    [struct sockaddr for sa_len],
    [isc_cv_platform_havesalen],
    [AC_COMPILE_IFELSE(
	[AC_LANG_PROGRAM(
	    [[
		#include <sys/types.h>
		#include <sys/socket.h>
	    ]],
	    [[
		extern struct sockaddr *ps;
		return ps->sa_len;
	    ]]
	)],
	[isc_cv_platform_havesalen=yes],
	[isc_cv_platform_havesalen=no]
    )]
)
case "$isc_cv_platform_havesalen" in
 yes)
    AC_DEFINE([ISC_PLATFORM_HAVESALEN], [1],
	 [struct sockaddr has sa_len?])
esac

AC_ARG_ENABLE(
    [ipv6],
    [AS_HELP_STRING(
	[--enable-ipv6],
	[s use IPv6?]
    )]
)

case "$enable_ipv6" in
 yes|''|autodetect)
    case "$host" in
     powerpc-ibm-aix4*)
	;;
     *)
	AC_DEFINE([WANT_IPV6], [1], [configure --enable-ipv6])
	;;
    esac
    ;;
 no)
    ;;
esac


AC_CACHE_CHECK(
    [for IPv6 structures],
    [isc_cv_found_ipv6],
    [AC_COMPILE_IFELSE(
	[AC_LANG_PROGRAM(
	    [[
		#include <sys/types.h>
		#include <sys/socket.h>
		#include <netinet/in.h>
	    ]],
	    [[
		struct sockaddr_in6 sin6;
	    ]]
	)],
	[isc_cv_found_ipv6=yes],
	[isc_cv_found_ipv6=no]
    )]
)

#
# See whether IPv6 support is provided via a Kame add-on.
# This is done before other IPv6 linking tests so LIBS is properly set.
#
AC_MSG_CHECKING([for Kame IPv6 support])
AC_ARG_WITH(
    [kame],
    [AS_HELP_STRING(
	[--with-kame],
	[- =/usr/local/v6]
    )],
    [use_kame="$withval"],
    [use_kame="no"]
)
case "$use_kame" in
 no)
    ;;
 yes)
    kame_path=/usr/local/v6
    ;;
 *)
    kame_path="$use_kame"
    ;;
esac
case "$use_kame" in
 no)
    AC_MSG_RESULT([no])
    ;;
 *)
    if test -f $kame_path/lib/libinet6.a; then
	AC_MSG_RESULT([$kame_path/lib/libinet6.a])
	LIBS="-L$kame_path/lib -linet6 $LIBS"
    else
	AC_MSG_ERROR([$kame_path/lib/libinet6.a not found.

Please choose the proper path with the following command:

    configure --with-kame=PATH
])
    fi
    ;;
esac

#
# Whether netinet6/in6.h is needed has to be defined in isc/platform.h.
# Including it on Kame-using platforms is very bad, though, because
# Kame uses #error against direct inclusion.   So include it on only
# the platform that is otherwise broken without it -- BSD/OS 4.0 through 4.1.
# This is done before the in6_pktinfo check because that's what
# netinet6/in6.h is needed for.
#
case "$host" in
 *-bsdi4.[[01]]*)
    AC_DEFINE([ISC_PLATFORM_NEEDNETINET6IN6H], [1],
	[Do we need netinet6/in6.h?])
    isc_netinet6in6_hack="#include <netinet6/in6.h>"
    ;;
 *)
    isc_netinet6in6_hack=""
    ;;
esac

#
# This is similar to the netinet6/in6.h issue.
#
case "$host" in
 *-sco-sysv*uw*|*-*-sysv*UnixWare*|*-*-sysv*OpenUNIX*)
    AC_DEFINE([ISC_PLATFORM_FIXIN6ISADDR], [1],
	[Do we need to fix in6isaddr?])
    isc_netinetin6_hack="#include <netinet/in6.h>"
    ;;
 *)
    isc_netinetin6_hack=""
    ;;
esac


case "$isc_cv_found_ipv6" in
 yes)
    AC_DEFINE([ISC_PLATFORM_HAVEIPV6], [1], [have IPv6?])
    AC_CACHE_CHECK(
	[for in6_pktinfo],
	[isc_cv_have_in6_pktinfo],
	[AC_COMPILE_IFELSE(
	    [AC_LANG_PROGRAM(
		[[
		    #include <sys/types.h>
		    #include <sys/socket.h>
		    #include <netinet/in.h>
		    $isc_netinetin6_hack
		    $isc_netinet6in6_hack
		]],
		[[
		    struct in6_pktinfo xyzzy;
		]]
	    )],
	    [isc_cv_have_in6_pktinfo=yes],
	    [isc_cv_have_in6_pktinfo=no]
	)]
    )
    case "$isc_cv_have_in6_pktinfo" in
     yes)
	AC_DEFINE([ISC_PLATFORM_HAVEIN6PKTINFO], [1],
		[have struct in6_pktinfo?])
    esac


    # HMS: Use HAVE_STRUCT_SOCKADDR_IN6_SIN6_SCOPE_ID instead?
    AC_CACHE_CHECK(
	[for sockaddr_in6.sin6_scope_id],
	[isc_cv_have_sin6_scope_id],
	[AC_COMPILE_IFELSE(
	    [AC_LANG_PROGRAM(
		[[
		    #include <sys/types.h>
		    #include <sys/socket.h>
		    #include <netinet/in.h>
		    $isc_netinetin6_hack
		    $isc_netinet6in6_hack
		]],
		[[
		    struct sockaddr_in6 xyzzy;
		    xyzzy.sin6_scope_id = 0;
		]]
	    )],
	    [isc_cv_have_sin6_scope_id=yes],
	    [isc_cv_have_sin6_scope_id=no]
	)]
    )

    case "$isc_cv_have_sin6_scope_id" in
     yes)
	AC_DEFINE([ISC_PLATFORM_HAVESCOPEID], [1], [sin6_scope_id?])
    esac
esac


# We need this check run even without isc_cv_found_ipv6=yes

AC_CACHE_CHECK(
    [for in6addr_any],
    [isc_cv_have_in6addr_any],
    [AC_LINK_IFELSE(
	[AC_LANG_PROGRAM(
	    [[
		#include <sys/types.h>
		#include <sys/socket.h>
		#include <netinet/in.h>
		$isc_netinetin6_hack
		$isc_netinet6in6_hack
	    ]],
	    [[
		struct in6_addr in6; 
		in6 = in6addr_any;
	    ]]
	)],
	[isc_cv_have_in6addr_any=yes],
	[isc_cv_have_in6addr_any=no]
    )]
)

case "$isc_cv_have_in6addr_any" in
 no)
    AC_DEFINE([ISC_PLATFORM_NEEDIN6ADDRANY], [1], [missing in6addr_any?])
esac


AC_CACHE_CHECK(
    [for struct if_laddrconf],
    [isc_cv_struct_if_laddrconf],
    [AC_COMPILE_IFELSE(
	[AC_LANG_PROGRAM(
	    [[
		#include <sys/types.h>
		#include <net/if6.h>
	    ]],
	    [[
		struct if_laddrconf a;
	    ]]
	)],
	[isc_cv_struct_if_laddrconf=yes],
	[isc_cv_struct_if_laddrconf=no]
    )]
)

case "$isc_cv_struct_if_laddrconf" in
 yes)
    AC_DEFINE([ISC_PLATFORM_HAVEIF_LADDRCONF], [1],
	[have struct if_laddrconf?])
esac

AC_CACHE_CHECK(
    [for struct if_laddrreq],
    isc_cv_struct_if_laddrreq,
    [AC_COMPILE_IFELSE(
	[AC_LANG_PROGRAM(
	    [[
		#include <sys/types.h>
		#include <net/if6.h>
	    ]],
	    [[
		struct if_laddrreq a;
	    ]]
	)],
	[isc_cv_struct_if_laddrreq=yes],
	[isc_cv_struct_if_laddrreq=no]
    )]
)

case "$isc_cv_struct_if_laddrreq" in
 yes)
    AC_DEFINE([ISC_PLATFORM_HAVEIF_LADDRREQ], [1],
	[have struct if_laddrreq?])
esac


])dnl
dnl ======================================================================