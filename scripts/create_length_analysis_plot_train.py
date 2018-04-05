import matplotlib
matplotlib.use('Agg')
import sys
import matplotlib.pyplot as plt
import numpy as np

def get_lengths(input_file):
	lengths = []
	for line in input_file.readlines():
		lengths.append(len(line.split()))
	return lengths

def get_histogram_freq(lengths, bins):
	bin_count = [0]*(len(bins)-1)
	for v in lengths:
		for i in range(len(bins)-1):
			if i < len(bins)-2:
				if v >= bins[i] and v < bins[i+1]:
					bin_count[i] += 1
			else:
				if v >= bins[i] and v <= bins[i+1]:
					bin_count[i] += 1
	N = len(lengths)
	bin_dist = [c*1.0/N for c in bin_count]
	return bin_dist

informal_file = open(sys.argv[1], 'r')
informal_lengths = get_lengths(informal_file)
formal_file = open(sys.argv[2], 'r')
formal_lengths = get_lengths(formal_file)
print np.mean(informal_lengths), np.std(informal_lengths)
print np.mean(formal_lengths), np.std(formal_lengths)
sys.exit(0)
bins = []
incr = 2
v = 5
while v <= 25:
	bins.append(v)
	v += incr 
informal_bin_dist = get_histogram_freq(informal_lengths, bins)
formal_bin_dist = get_histogram_freq(formal_lengths, bins)
output_file = open(sys.argv[2]+'.lengths.plot.tsv', 'w')
output_file.write('Bins\tScore\tInformal\tScore\tFormal\n')
for i in range(len(bins)-1):
	line = '[%s,%s)\t' % (bins[i], bins[i+1])
	line += '%s\t%s\t' % (bins[i], informal_bin_dist[i])
	line += '%s\t%s' % (bins[i], formal_bin_dist[i])
	output_file.write(line+'\n')

