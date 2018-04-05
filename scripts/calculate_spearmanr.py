import matplotlib
matplotlib.use('Agg')
import sys
import scipy.stats
import matplotlib.pyplot as plt

automatic_metric_scores_file = open(sys.argv[1], 'r')
human_judgment_scores_file = open(sys.argv[2], 'r')

if 'terp' in sys.argv[1]:
	automatic_metric_scores = [score.split()[2] for score in automatic_metric_scores_file.readlines()]
elif 'pinc' in sys.argv[1]:
	automatic_metric_scores = [score.split()[1] for score in automatic_metric_scores_file.readlines()]
else:
	automatic_metric_scores = [score.split()[0] for score in automatic_metric_scores_file.readlines()]

human_judgment_scores = [score.split()[0] for score in human_judgment_scores_file.readlines()]
assert(len(automatic_metric_scores) == len(human_judgment_scores))
new_automatic_metric_scores = []
new_human_judgment_scores = []
xy_values = []
for i in range(len(human_judgment_scores)):
	if automatic_metric_scores[i]!= 'None' and human_judgment_scores[i] != 'None':
		new_automatic_metric_scores.append(float(automatic_metric_scores[i]))
		new_human_judgment_scores.append(float(human_judgment_scores[i]))
		xy_values.append((automatic_metric_scores[i], float(human_judgment_scores[i])))
print len(new_automatic_metric_scores)
print len(new_human_judgment_scores)
print(scipy.stats.spearmanr(new_automatic_metric_scores, new_human_judgment_scores, nan_policy='omit'))
#print(scipy.stats.spearmanr(new_automatic_metric_scores, new_human_judgment_scores))
#xy_values = sorted(xy_values, key=lambda x: x[0])
#x_values = []
#y_values = []
#for x,y in xy_values:
#	x_values.append(x)
#	y_values.append(y)
#plt.plot(x_values, y_values, 'ro')
#plt.savefig('plot.png')
