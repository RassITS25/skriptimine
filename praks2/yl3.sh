#!/bin/bash
# aja kalendri väljastamine
date +"Today is %A, %B, %Y"
date +"Time is %H:%M"
echo
date +"Calendar  of %B %Y"
ncal -C | tail -7
