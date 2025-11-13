#!/bin/bash

bison -yd delete.y
flex -i delete.l
gcc lex.yy.c y.tab.c -o delete
./delete
