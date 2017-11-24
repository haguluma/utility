#! /bin/bash

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
export CFLAGS=$(pkg-config --cflags glib-2.0)
export LDFLAGS=$(pkg-config --libs glib-2.0)

gcc mv_proc.c $CFLAGS $LDFLAGS -o mv_proc
