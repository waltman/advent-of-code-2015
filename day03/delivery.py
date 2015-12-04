#!/usr/bin/env python
from sys import argv
from sets import Set

script, filename = argv

with open(filename) as f :
    for line in f :
        line = line.rstrip("\n")
        x = y = 0
        s = Set()
        s.add("0,0")
        for i, c in enumerate(line) :
            if c == ">" :
                x += 1
            elif c == "<" :
                x -= 1
            elif c == "^" :
                y += 1
            elif c == "v" :
                y -= 1

            s.add("%d,%d" % (x, y))

        print len(s)
