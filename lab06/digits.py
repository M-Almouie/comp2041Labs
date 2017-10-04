#!/usr/bin/python3
import math, sys, string
line = sys.stdin.read()
line.rstrip('\n')
print(line.translate({ord('0'): u'<', ord('1'): u'<', ord('2'): u'<',ord('3'): u'<',
ord('4'): u'<',ord('6'): u'>',ord('7'): u'>',ord('8'): u'>',ord('9'): u'>'}), end='')

