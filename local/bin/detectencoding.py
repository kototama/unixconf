#!/usr/bin/python

import chardet, sys, getopt

## parsing options
def usage():
    print """Detects encoding of a sigle given file. Usage:
%s filename

Detects
 - ASCII, UTF-8, UTF-16 (2 variants), UTF-32 (4 variants)
 - Big5, GB2312, EUC-TW, HZ-GB-2312, ISO-2022-CN (Traditional and Simplified Chinese)
 - EUC-JP, SHIFT_JIS, ISO-2022-JP (Japanese)
 - EUC-KR, ISO-2022-KR (Korean)
 - KOI8-R, MacCyrillic, IBM855, IBM866, ISO-8859-5, windows-1251 (Cyrillic)
 - ISO-8859-2, windows-1250 (Hungarian)
 - ISO-8859-5, windows-1251 (Bulgarian)
 - windows-1252 (English)
 - ISO-8859-7, windows-1253 (Greek)
 - ISO-8859-8, windows-1255 (Visual and Logical Hebrew)
 - TIS-620 (Thai)

The only option is -h (or --help) - which gives that message.""" %sys.argv[0]

try:
    opts, args = getopt.getopt(sys.argv[1:], 'h', ['help'])
except getopt.GetoptError:
    usage()
    sys.exit(2)

for opt, arg in opts:
    if opt in ('-h', '--help'):
        usage()

        sys.exit(2)
    else:
        usage()
        sys.exit(2)

if len(args) != 1:
    usage()

## program:
myfile = sys.argv[1]

data = open(myfile).read()
print chardet.detect(data)
