import matplotlib
matplotlib.use('Agg')
import sys
import matplotlib.pyplot as plt
import numpy as np

def get_editdists(input_file):
	editdists = []
	for line in input_file.readlines():
		editdists.append(int(line.strip('\n')))
	return editdists

def get_histogram_freq(editdists, bins):
	bin_count = [0]*(len(bins)-1)
	for v in editdists:
		for i in range(len(bins)-1):
			if i < len(bins)-2:
				if v >= bins[i] and v < bins[i+1]:
					bin_count[i] += 1
			else:
				if v >= bins[i] and v <= bins[i+1]:
					bin_count[i] += 1
	N = len(editdists)
	bin_dist = [c*1.0/N for c in bin_count]
	return bin_dist

formal_file = open(sys.argv[1], 'r')
formal_editdists = get_editdists(formal_file)
print np.mean(formal_editdists), np.std(formal_editdists)
sys.exit(0)
min_v = min(formal_editdists)
bins = []
incr = 10
v = min_v
while v <= 100:
	bins.append(v)
	v += incr 
formal_bin_dist = get_histogram_freq(formal_editdists, bins)
output_file = open(sys.argv[1]+'.plot.tsv', 'w')
output_file.write('Bins\tScore\tFormal\n')
for i in range(len(bins)-1):
	line = '[%s,%s)\t' % (bins[i], bins[i+1])
	line += '%s\t%s' % (bins[i], formal_bin_dist[i])
	output_file.write(line+'\n')

