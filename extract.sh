#

echo Extracting text from ISO Fortran spec and extracting rules. 1>&2
tritext.exe --markup $@ 2> /dev/null | ./extraction/bin/Debug/net8.0/RuleExtraction.exe

echo Clean up. 1>&2
rm -rf bin obj
