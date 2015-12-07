#!/usr/bin/env python
import fileinput
import re
import sys
import string
from numpy import *

XMAX = 1000
YMAX = 1000

# initialize
light = zeros([XMAX, YMAX])

# parse the instructions
for line in fileinput.input() :
    line = line.rstrip("\n")
    m = re.search('(\d+),(\d+) through (\d+),(\d+)', line)
    if m != None :
        (x1, y1, x2, y2) = m.group(1, 2, 3, 4)
        x1 = int(x1)
        y1 = int(y1)
        x2 = int(x2) + 1
        y2 = int(y2) + 1

    if string.find(line, "turn on") == 0:
        light[y1:y2, x1:x2] = 1

    if string.find(line, "turn off") == 0 :
        light[y1:y2, x1:x2] = 0

    if string.find(line, "toggle") == 0:
        r = light[y1:y2, x1:x2]
        r[r == 1]  = -1
        r[r == 0]  =  1
        r[r == -1] =  0
        light[y1:y2, x1:x2] = r
        
    if string.find(line, "print") == 0:
        print light

num_on = sum(light)
print "%d lights on" % num_on
