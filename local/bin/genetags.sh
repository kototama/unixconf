#!/bin/bash

find . -name '*.clj' | xargs etags --regex='/[ \t\(]*def[a-z]* \([a-z-!]+\)/\1/' --regex='/[ \t\(]*ns \([a-z.]+\)/\1/'
find . -name '*.js' | xargs etags --append --regex='/\.([a-z.]+) = function/\1/'


