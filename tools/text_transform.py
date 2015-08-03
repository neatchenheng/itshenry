#!/bin/python
import os,sys
from datetime import datetime

def text_transform(file_name,origin_encode, target_encode):
	if file_name and os.path.exists(file_name):
		f = open(file_name)
		content = f.read().decode(origin_encode).encode(target_encode)
		f.close()
		now = datetime.now()
		file_name = now.strftime('%Y%m%d%H%M%S')
		f = open("%s.%s" % (file_name, target_encode),"w+")
		f.write(content)
		f.close()
	else:
		print "no such file"

def usage():
	print "NAME"
	print "\ttransform text from origin encode to target encode"
	print "SYNOPSIS"
	print "\tpython text_transform.py FILENAME OPTION"
	print "FILENAME"
	print "\tfile name"
	print "OPTION"
	print "\torigin_encode"
	print "\t\tfile origin encode"
	print "\ttarget_encode"
	print "\t\tfile target encode"
	print "USAGE"
	print "\tpython text_transform.py test_file gbk utf8"

if __name__ == "__main__":
	args = sys.argv
	if len(args) < 4:
		usage()
		exit(1)
	text_transform(args[1],args[2],args[3])
