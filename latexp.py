import mdtex2html

def conv(x):
	return mdtex2html.convert(x)

# read file

with open("latexpx.inp") as fin:
	content_latex = fin.readlines()

# convert each line

content_html = list( map ( lambda line: conv(line), content_latex))

# write file

with open("latexpx.out", "w") as fout:
	fout.writelines(content_html) 




