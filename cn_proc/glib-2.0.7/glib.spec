Name:		glib2
Summary:	Handy library of utility functions
Version:	2.0.7
Release:	1
License:	LGPL
Group:		Development/Libraries
Source:		ftp://ftp.gimp.org/pub/gtk/v2.0/glib-%{version}.tar.gz
BuildRoot:	/var/tmp/%{name}-%{version}-root
URL:		http://www.gtk.org

%description
Handy library of utility functions.  Development libs and headers
are in glib-devel.

%package devel
Summary:	GIMP Toolkit and GIMP Drawing Kit support library
Group:		Development/Libraries
Requires:	%{name} = %{version}

%description devel
Static libraries and header files for the support library for the GIMP's X
libraries, which are available as public libraries.  GLIB includes generally
useful data structures.

%prep
%setup -q -n glib-%{version}

%build
CFLAGS="$RPM_OPT_FLAGS"
./configure --prefix=%{_prefix} \
    --bindir=%{_bindir} --mandir=%{_mandir} \
    --localstatedir=%{_localstatedir} --libdir=%{_libdir} \
    --datadir=%{_datadir} --includedir=%{_includedir} \
    --sysconfdir=%{_sysconfdir} --disable-gtk-doc
make

%install
rm -rf $RPM_BUILD_ROOT

make prefix=$RPM_BUILD_ROOT%{_prefix} bindir=$RPM_BUILD_ROOT%{_bindir} \
    mandir=$RPM_BUILD_ROOT%{_mandir} libdir=$RPM_BUILD_ROOT%{_libdir} \
    localstatedir=$RPM_BUILD_ROOT%{_localstatedir} \
    datadir=$RPM_BUILD_ROOT%{_datadir} \
    includedir=$RPM_BUILD_ROOT%{_includedir} \
    sysconfdir=$RPM_BUILD_ROOT%{_sysconfdir} install

%clean
rm -rf $RPM_BUILD_ROOT

%post -p /sbin/ldconfig

%postun -p /sbin/ldconfig

%files
%defattr(-, root, root)

%doc AUTHORS COPYING ChangeLog NEWS README
%{_libdir}/lib*.so.*

%files devel
%defattr(-, root, root)

%{_libdir}/lib*.so
%{_libdir}/*a
%{_libdir}/glib-2.0
%{_libdir}/pkgconfig/*.pc
%{_includedir}/glib-2.0
%{_mandir}/man1/glib-*
%{_datadir}/aclocal/*
%{_bindir}/*
#%{_datadir}/gtk-doc/html/glib-2.0
#%{_datadir}/gtk-doc/html/gobject

%changelog
* Mon Aug 27 2001 Jens Finke <jens@gnome.org>
- Changed package name to glib2. 
- Updated source URL.

* Mon Aug 14 2001 Jens Finke <jens@gnome.org>
- Updated to match gpp standard:
 - removed all hardcoded paths, use rpm macros instead
 - changed Copyright to License
 - removed explicit docdir definition 
 - added 'Requires' to devel package
 - added paths to 'configure' and 'make' calls
 - moved %changelog section to the end of the file
 - updated files section to match changes in glib-2.0

* Tue Jun  1 1999 Jose Mercado <jmercado@mit.edu>
- fixed version numbers in files section.

* Thu Feb 11 1999 Michael Fulbright <drmike@redhat.com>
- added libgthread to file list

* Fri Feb 05 1999 Michael Fulbright <drmike@redhat.com>
- version 1.1.15

* Wed Feb 03 1999 Michael Fulbright <drmike@redhat.com>
- version 1.1.14

* Mon Jan 18 1999 Michael Fulbright <drmike@redhat.com>
- version 1.1.13

* Wed Jan 06 1999 Michael Fulbright <drmike@redhat.com>
- version 1.1.12

* Wed Dec 16 1998 Michael Fulbright <drmike@redhat.com>
- updated in preparation for the GNOME freeze

* Mon Apr 13 1998 Marc Ewing <marc@redhat.com>
- Split out glib package
