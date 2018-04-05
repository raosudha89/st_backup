import sys
import numpy as np
judgments_part1 = open(sys.argv[1], 'r').readlines()
judgments_part2 = open(sys.argv[2], 'r').readlines()
judgments_comb = open(sys.argv[3], 'w')
for i in range(500):
	avg, judgments1, sent1 = judgments_part1[i].split('\t')
	judgments = []
	if avg != 'None':
		judgments = judgments1.split(',')	
	avg, judgments2, sent2 = judgments_part2[i].split('\t')
	if avg != 'None':
		judgments += judgments2.split(',')
	if judgments == []:
		judgments_comb.write('None\tNone\tNone\t%s' % sent1)
	else:
		judgments_comb.write('%.2f\t%s\t%s' % (np.mean([float(v) for v in judgments]), ','.join(judgments), sent1))
