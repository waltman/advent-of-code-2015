#!/usr/bin/env python
import fileinput
import re
import sys
import string
from pylab import *

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
        light[y1:y2, x1:x2] += 1

    if string.find(line, "turn off") == 0 :
        r = light[y1:y2, x1:x2]
        r -= 1
        r[r < 0] = 0
        light[y1:y2, x1:x2] = r
        

    if string.find(line, "toggle") == 0:
        light[y1:y2, x1:x2] += 2
        
    if string.find(line, "print") == 0:
        print light

total_brightness = sum(light)
print "total brightness = %d" % total_brightness
