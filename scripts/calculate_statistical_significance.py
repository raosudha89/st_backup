import sys
import scipy.stats

if 'terp' in sys.argv[1]:
	scores_1 = [score.split()[2] for score in open(sys.argv[1], 'r').readlines()]
elif 'pinc' in sys.argv[1]:
	scores_1 = [score.split()[1] for score in open(sys.argv[1], 'r').readlines()]
else:
	scores_1 = [score.strip('\n').split()[0] for score in open(sys.argv[1], 'r').readlines()]

if 'terp' in sys.argv[2]:
	scores_2 = [score.split()[2] for score in open(sys.argv[2], 'r').readlines()]
elif 'pinc' in sys.argv[2]:
	scores_2 = [score.split()[1] for score in open(sys.argv[2], 'r').readlines()]
else:
	scores_2 = [score.strip('\n').split()[0] for score in open(sys.argv[2], 'r').readlines()]
new_scores_1 = []
new_scores_2 = []
for i in range(len(scores_1)):
	if scores_1[i]!= 'None' and scores_2[i] != 'None':
		new_scores_1.append(float(scores_1[i]))
		new_scores_2.append(float(scores_2[i]))

print scipy.stats.ttest_rel(new_scores_1, new_scores_2, nan_policy='omit')
