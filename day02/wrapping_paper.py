#!/usr/bin/env python
from sys import argv

def wrapping(d) :
    volume = smallest = 0
    
    for i in range(0, 2) :
        for j in range(i+1, 3) :
            area = d[i] * d[j]
            volume += 2 * area
            if smallest == 0 or area < smallest :
                smallest = area

    return volume + smallest

def ribbon(d) :
    smallest = 0

    for i in range(0, 2) :
        for j in range(i+1, 3) :
            perim = 2 * (d[i] + d[j])
            if smallest == 0 or perim < smallest :
                smallest = perim

    return smallest + d[0] * d[1] * d[2]

script, filename = argv

with open(filename) as f :
    total_wrapping = total_ribbon = 0
    
    for line in f :
        line = line.rstrip("\n")
        d = line.split('x')
        for i in range(len(d)) :
            d[i] = int(d[i])
            
        wrap = wrapping(d)
        rib = ribbon(d)
        print "%10d %10d %s" % (wrap, rib, line)
        total_wrapping += wrap
        total_ribbon += rib

print "total wrapping = %d" % total_wrapping
print "total ribbon = %d" % total_ribbon

