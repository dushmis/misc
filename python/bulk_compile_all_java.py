#!/usr/bin/python -tt


import commands
import re
import sys

def aray__to_string(ar):
	array_string=""
	for item in ar:
		array_string += " "+item
	array_string=array_string.replace(ar[0],"")
	return array_string.rstrip().lstrip()
	
def get_class_path():
  #using find /xyz/abc/lib/ -type f \( -name  "*.jar" -o -name "*.zip" \) | paste -sd: >> classpath
	f=open("classpath")
	lines=f.readlines()
	return str(lines[0].split("\n")[0])+":."
	
def __file__log__(s,filename):
	f=open(filename,"a")
	f.write(str(s)+"\n")
	f.flush()
	f.close()

def main():
	classpath = get_class_path()
	(status,output)=commands.getstatusoutput("find "+aray__to_string(sys.argv)+" -type f -name \"*.java\"")
	filestocompile = []
	filestoignore = []
	alllines = []
	alllines = output
	alllines = alllines.split("\n")
	for lines in alllines:
		if lines.__contains__("WEB-INF") and lines.__contains__("classes"):
			filestocompile.append(lines)
		else:
			filestoignore.append(lines)
	del alllines
	
	
	for files in filestocompile:
		directory = re.findall(r".+classes.",files)[0]
		filesname = files.split(directory)[1]
		file = "cd "+directory+"; javac -cp "+classpath+" "+filesname;
		(status,outout)=commands.getstatusoutput(file)
		__file__log__(str(status) + " " + directory + " " + filesname + " - " + files,"comp.py.log")
		__file__log__(outout,"debug.compile.log")

if __name__ == "__main__":
	main()
