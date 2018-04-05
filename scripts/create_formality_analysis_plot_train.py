import matplotlib
matplotlib.use('Agg')
import sys
import matplotlib.pyplot as plt
import numpy as np

def get_formalities(input_file):
	formalities = []
	for line in input_file.readlines():
		formalities.append(float(line.split('\t')[0]))
	return formalities

def get_histogram_freq(formalities, bins):
	bin_count = [0]*(len(bins)-1)
	for v in formalities:
		for i in range(len(bins)-1):
			if i < len(bins)-2:
				if v >= bins[i] and v < bins[i+1]:
					bin_count[i] += 1
			else:
				if v >= bins[i] and v <= bins[i+1]:
					bin_count[i] += 1
	N = len(formalities)
	bin_dist = [c*1.0/N for c in bin_count]
	return bin_dist

informal_file = open(sys.argv[1], 'r')
formal_ref_file = open(sys.argv[2], 'r')
bins = []
incr = 0.25
v = -3.0
while v <= 3.0:
	bins.append(v)
	v += incr 
	
informal_formalities = get_formalities(informal_file)
print np.mean(informal_formalities), np.std(informal_formalities)
informal_bin_dist = get_histogram_freq(informal_formalities, bins)
formal_ref_formalities = get_formalities(formal_ref_file)
print np.mean(formal_ref_formalities), np.std(formal_ref_formalities)
formal_ref_bin_dist = get_histogram_freq(formal_ref_formalities, bins)
output_file = open(sys.argv[3], 'w')
output_file.write('Bins\tScore\tInformal\tScore\tFormal Rewrite\n')
for i in range(len(bins)-1):
	line = '[%s,%s)\t' % (bins[i], bins[i+1])
	line += '%s\t%s\t' % (bins[i], informal_bin_dist[i])
	line += '%s\t%s' % (bins[i], formal_ref_bin_dist[i])
	output_file.write(line+'\n')

