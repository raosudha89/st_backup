import matplotlib
matplotlib.use('Agg')
import sys
import matplotlib.pyplot as plt
import numpy as np

def get_x_y(informal_prefix, formal_prefix, suffix_x, suffix_y):
	if 'meaning' not in suffix_y:
		informal_lines = open(informal_prefix + '.' + suffix_y, 'r').readlines()
	formal_lines = open(formal_prefix + '.' + suffix_y, 'r').readlines()
	editdist_lines = open(formal_prefix + '.' + suffix_x, 'r').readlines()
	x_values = []
	y_values = []
	xy_values = []
	for i in range(len(formal_lines)):
		if 'meaning' not in suffix_y:
			informal_score = informal_lines[i].split('\t')[0]
			informal_sent = informal_lines[i].split('\t')[-1].strip('\n')
		formal_score = formal_lines[i].split('\t')[0]
		formal_sent = formal_lines[i].split('\t')[-1].strip('\n')
		if 'meaning' not in suffix_y:
			if informal_score == 'None' or formal_score == 'None':
				continue
		else:
			if formal_score == 'None':
				continue
		if 'meaning' not in suffix_y:
			informal_score = float(informal_score)
		formal_score = float(formal_score)
		editdist = int(editdist_lines[i].strip('\n'))
		if editdist > 75:
			continue
		if 'meaning' in suffix_y:
			xy_values.append((editdist, formal_score))
		else:
			xy_values.append((editdist, formal_score-informal_score))
	xy_values = sorted(xy_values, key=lambda x: x[0])
	for (x,y) in xy_values:
		x_values.append(x)
		y_values.append(y)
	return x_values, y_values

suffix_x = 'editdist'
suffix_y = 'formality.human'
informal_prefix = sys.argv[1]
colors = ['g.', 'b.', 'y.', 'c.', 'm.', 'k']
models = ['Ref', 'SMT Combined', 'NMT Baseline', 'NMT Copy', 'NMT Combined']
for i in [2, 3, 4]:
	formal_prefix = sys.argv[i]
	x, y = get_x_y(informal_prefix, formal_prefix, suffix_x, suffix_y)
	plt.plot(x, y, colors[i-2], label=models[i-2])
plt.xlabel('Edit Distance')
plt.ylabel('Difference in Formality Score')
plt.legend()
plt.savefig('EM_Formality_EditDist.png')
plt.gcf().clear()

suffix_x = 'editdist'
suffix_y = 'fluency.human'
informal_prefix = sys.argv[1]
colors = ['g.', 'b.', 'y.', 'c.', 'm.', 'k']
models = ['Ref', 'SMT Combined', 'NMT Baseline', 'NMT Copy', 'NMT Combined']
for i in [2, 3, 4]:
	formal_prefix = sys.argv[i]
	x, y = get_x_y(informal_prefix, formal_prefix, suffix_x, suffix_y)
	plt.plot(x, y, colors[i-2], label=models[i-2])
plt.xlabel('Edit Distance')
plt.ylabel('Difference in Fluency Score')
plt.legend()
plt.savefig('EM_Fluency_EditDist.png')
plt.gcf().clear()

suffix_x = 'editdist'
suffix_y = 'meaning.human'
informal_prefix = sys.argv[1]
colors = ['g.', 'b.', 'y.', 'c.', 'm.', 'k']
models = ['Ref', 'SMT Combined', 'NMT Baseline', 'NMT Copy', 'NMT Combined']
for i in [2, 3, 4]:
	formal_prefix = sys.argv[i]
	x, y = get_x_y(informal_prefix, formal_prefix, suffix_x, suffix_y)
	plt.plot(x, y, colors[i-2], label=models[i-2])
plt.xlabel('Edit Distance')
plt.ylabel('Meaning Score')
plt.legend()
plt.savefig('EM_Meaning_EditDist.png')
plt.gcf().clear()

