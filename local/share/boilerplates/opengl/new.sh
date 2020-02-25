#!/usr/bin/env sh

cat >Makefile <<EOF
IDIR=include
CC=g++
CFLAGS=-std=c++11 -I\$(IDIR)

LIBS=-lGL -lglfw -lX11 -lpthread -lXrandr -lXi -ldl -lassimp
SRC=src/*.cpp src/glad.c
DEPS=\$(IDIR)/*.h

$1: \$(SRC) \$(DEPS)
	\$(CC) \$(CFLAGS) \$(SRC) -o \$@ \$(LIBS)
EOF
