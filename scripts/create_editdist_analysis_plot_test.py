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

formal_ref0_file = open(sys.argv[1], 'r')
formal_ref0_editdists = get_editdists(formal_ref0_file)
print np.mean(formal_ref0_editdists), np.std(formal_ref0_editdists)
formal_ref1_file = open(sys.argv[2], 'r')
formal_ref1_editdists = get_editdists(formal_ref1_file)
print np.mean(formal_ref1_editdists), np.std(formal_ref1_editdists)
formal_ref2_file = open(sys.argv[3], 'r')
formal_ref2_editdists = get_editdists(formal_ref2_file)
print np.mean(formal_ref2_editdists), np.std(formal_ref2_editdists)
formal_ref3_file = open(sys.argv[4], 'r')
formal_ref3_editdists = get_editdists(formal_ref3_file)
print np.mean(formal_ref3_editdists), np.std(formal_ref3_editdists)
sys.exit(0)
output_file = open(sys.argv[5], 'w')
bins = []
incr = 10
v = 0
while v <= 100:
	bins.append(v)
	v += incr 
formal_ref0_bin_dist = get_histogram_freq(formal_ref0_editdists, bins)
formal_ref1_bin_dist = get_histogram_freq(formal_ref1_editdists, bins)
formal_ref2_bin_dist = get_histogram_freq(formal_ref2_editdists, bins)
formal_ref3_bin_dist = get_histogram_freq(formal_ref3_editdists, bins)
output_file.write('Bins\tScore\tFormal Rewrite 1\tScore\tFormal Rewrite 2\tScore\tFormal Rewrite 3\tScore\tFormal Rewrite 4\n')
for i in range(len(bins)-1):
	line = '[%s,%s)\t' % (bins[i], bins[i+1])
	line += '%s\t%s\t' % (bins[i], formal_ref0_bin_dist[i])
	line += '%s\t%s\t' % (bins[i], formal_ref1_bin_dist[i])
	line += '%s\t%s\t' % (bins[i], formal_ref2_bin_dist[i])
	line += '%s\t%s' % (bins[i], formal_ref3_bin_dist[i])
	output_file.write(line+'\n')

