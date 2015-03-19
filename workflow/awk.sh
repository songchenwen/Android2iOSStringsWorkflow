#!/bin/sh
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

pbpaste | awk '
BEGIN{
	FS = "^ *<string *| *>|<\/string> *$|^ *<!-- *| *--> *$";
}
{
	if (/<string.*name\=\".*\".*>.*<\/string> *$/){
		match($2, /name *\= *\"[^ ]+\"/)
		name = substr($2, RSTART + 5, RLENGTH - 5)	
		print name " \= \"" $3 "\";"
	}
	else if(/<!--.*-->/)
		print "// "$2;
	else if(/^ *$/)
		print ""
}'