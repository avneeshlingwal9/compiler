#!/bin/bash

bison -yd delete.y
flex delete.l
gcc lex.yy.c y.tab.c -o delete
./delete
