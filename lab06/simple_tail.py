#!/usr/bin/python3
import sys
i = 1
while i < len(sys.argv):
    f = open(sys.argv[i], 'r')
    # lines = f.readlines()
    # lines[-10:]    
    
    lines = f.read().splitlines()
    if len(lines) >= 10:
        j = len(lines)-10
        while j < len(lines):
            print(lines[j])
            j = j + 1
    else:
        m = 0
        while m < len(lines): 
            print(lines[m])
            m = m + 1
    i = i + 1
