import matplotlib
matplotlib.use('Agg')
import sys
import matplotlib.pyplot as plt
import numpy as np

def get_x_y(informal_prefix, formal_prefix, suffix_y):
	if 'formality' in suffix_y or 'fluency' in suffix_y:
		informal_lines = open(informal_prefix + '.' + suffix_y, 'r').readlines()
	else:
		informal_lines = open(informal_prefix, 'r').readlines()
	formal_lines = open(formal_prefix + '.' + suffix_y, 'r').readlines()
	x_values = []
	y_values = []
	xy_values = []
	for i in range(len(formal_lines)):
		if 'formality' in suffix_y or 'fluency' in suffix_y:
			informal_score = informal_lines[i].split('\t')[0]
			informal_sent = informal_lines[i].split('\t')[-1].strip('\n')
		else:
			informal_sent = informal_lines[i].strip('\n')
		informal_len = len(informal_sent)
		formal_score = formal_lines[i].split('\t')[0]
		formal_sent = formal_lines[i].split('\t')[-1].strip('\n')
		formal_len = len(formal_sent)
		if 'formality' in suffix_y or 'fluency' in suffix_y:
			if informal_score == 'None' or formal_score == 'None':
				continue
			informal_score = float(informal_score)
		if formal_score == 'None':
			continue
		formal_score = float(formal_score)
		if 'formality' in suffix_y or 'fluency' in suffix_y:
			xy_values.append((informal_len, formal_score-informal_score))
		else:
			xy_values.append((informal_len, formal_score))
	xy_values = sorted(xy_values, key=lambda x: x[0])
	for (x,y) in xy_values:
		x_values.append(x)
		y_values.append(y)
	return x_values, y_values

suffixes_y = ['formality.human', 'fluency.human', 'meaning.human', 'combined.human']
informal_prefix = sys.argv[1]
colors = ['r.', 'y.', 'g.', 'm.', 'c.', 'c.', 'k.']
models = ['Ref','Rule Based', 'SMT Combined', 'NMT Baseline', 'NMT Copy', 'NMT Combined']

for suffix_y in suffixes_y:
	for i in [2, 4, 7]:
		formal_prefix = sys.argv[i]
		x, y = get_x_y(informal_prefix, formal_prefix, suffix_y)
		plt.plot(x, y, colors[i-2], label=models[i-2])
	plt.legend()
	plt.xlabel('Length')
	plt.ylabel(suffix_y)	
	plt.savefig('EM_'+suffix_y+'_len.png')
	plt.gcf().clear()

#output_file = open(sys.arv[-1], 'w')
#for i in range(formal_values[0]):
#	output_line_vals = []
#	for j in range(num_formals):
#		output_line_vals.append(formal_values[j][i][0])
#		output_line_vals.append(formal_values[j][i][1])
#	output_line = ','.join(output_line_vals) + '\n'
#	output_file.write(output_line)
