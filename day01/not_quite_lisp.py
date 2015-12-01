from sys import argv

script, filename = argv

with open(filename) as f :
    for line in f :
        fl = basement = 0
        for i, c in enumerate(line) :
            if c == "(" :
                fl += 1 
            elif c == ")" :
                fl -= 1
                if fl < 0 and basement == 0 :
                    basement = i + 1
            elif c == "\n" :
                print "floor = %d, basement = %d" % (fl, basement)
                fl = basement = 0
