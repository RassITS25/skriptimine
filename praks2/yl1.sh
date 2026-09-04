#!/bin/bash

echo "Tere, $(whoami | cut -c1 | tr 'a-z' 'A-Z')$(whoami | cut -c2- | tr 'A-Z' 'a-z')!"
