NULL =
BUILT_SOURCES =
CLEANFILES =
DISTCLEANFILES =

std_unity_list =	 						\
	$(abs_top_srcdir)/sntp/unity/auto/generate_test_runner.rb	\
	$(abs_srcdir)/testconf.yml					\
	$(NULL)

run_unity =	ruby $(std_unity_list)

EXTRA_DIST =				\
	testconf.yml			\
	$(NULL)

check_PROGRAMS = 	\
	test-ntpq	\
	$(NULL)

LDADD =					\
	$(top_builddir)/ntpq/libntpq.a	\
	$(top_builddir)/libntp/libntp.a	\
	$(LDADD_LIBNTP)			\
	$(PTHREAD_LIBS)			\
	$(LDADD_NTP)			\
	$(NULL)

unity_tests_LDADD =				\
	$(LDADD)				\
	$(top_builddir)/sntp/unity/libunity.a	\
	$(LIBM)					\
	$(NULL)

AM_CFLAGS   = $(CFLAGS_NTP)
AM_CFLAGS += $(NTP_HARD_CFLAGS)

AM_CPPFLAGS  = $(NTP_INCS)
AM_CPPFLAGS += -I$(top_srcdir)/ntpq
AM_CPPFLAGS += $(CPPFLAGS_NTP)
AM_CPPFLAGS += -DUNITY_INCLUDE_CONFIG_H
AM_CPPFLAGS += -I$(top_srcdir)/sntp/unity
AM_CPPFLAGS += $(LIBOPTS_CFLAGS)
AM_CPPFLAGS += $(NTP_HARD_CPPFLAGS)

AM_LDFLAGS  = $(LDFLAGS_NTP)
AM_LDFLAGS += $(NTP_HARD_LDFLAGS)

BUILT_SOURCES +=			\
	$(srcdir)/run-t-ntpq.c		\
	$(NULL)

noinst_HEADERS =			\
	$(NULL)

###

test_ntpq_LDADD =			\
	$(unity_tests_LDADD)		\
	$(NULL)

test_ntpq_SOURCES =			\
	t-ntpq.c			\
	run-t-ntpq.c			\
	$(NULL)

$(srcdir)/run-t-ntpq.c: $(srcdir)/t-ntpq.c $(std_unity_list)
	$(run_unity) $< $@


TESTS =

if !NTP_CROSSCOMPILE
TESTS += $(check_PROGRAMS)
endif

include $(top_srcdir)/check-libntp.mf
include $(top_srcdir)/check-libunity.mf
include $(top_srcdir)/depsver.mf
include $(top_srcdir)/includes.mf
