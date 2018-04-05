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
formal_ref0_file = open(sys.argv[2], 'r')
formal_ref1_file = open(sys.argv[3], 'r')
formal_ref2_file = open(sys.argv[4], 'r')
formal_ref3_file = open(sys.argv[5], 'r')
bins = []
incr = 0.25
v = -3.0
while v <= 3.0:
	bins.append(v)
	v += incr 
	
informal_formalities = get_formalities(informal_file)
print np.mean(informal_formalities), np.std(informal_formalities)
informal_bin_dist = get_histogram_freq(informal_formalities, bins)
formal_ref0_formalities = get_formalities(formal_ref0_file)
print np.mean(formal_ref0_formalities), np.std(formal_ref0_formalities)
formal_ref0_bin_dist = get_histogram_freq(formal_ref0_formalities, bins)
formal_ref1_formalities = get_formalities(formal_ref1_file)
print np.mean(formal_ref1_formalities), np.std(formal_ref1_formalities)
formal_ref1_bin_dist = get_histogram_freq(formal_ref1_formalities, bins)
formal_ref2_formalities = get_formalities(formal_ref2_file)
print np.mean(formal_ref2_formalities), np.std(formal_ref2_formalities)
formal_ref2_bin_dist = get_histogram_freq(formal_ref2_formalities, bins)
formal_ref3_formalities = get_formalities(formal_ref3_file)
print np.mean(formal_ref3_formalities), np.std(formal_ref3_formalities)
formal_ref3_bin_dist = get_histogram_freq(formal_ref3_formalities, bins)
sys.exit(0)
output_file = open(sys.argv[6], 'w')
output_file.write('Bins\tScore\tInformal\tScore\tFormal Ref1\tScore\tFormal Ref2\tScore\t Formal Ref3\tScore\tFormal Ref4\n')
for i in range(len(bins)-1):
	line = '[%s,%s)\t' % (bins[i], bins[i+1])
	line += '%s\t%s\t' % (bins[i], informal_bin_dist[i])
	line += '%s\t%s\t' % (bins[i], formal_ref0_bin_dist[i])
	line += '%s\t%s\t' % (bins[i], formal_ref1_bin_dist[i])
	line += '%s\t%s\t' % (bins[i], formal_ref2_bin_dist[i])
	line += '%s\t%s' % (bins[i], formal_ref3_bin_dist[i])
	output_file.write(line+'\n')

#plt.savefig('em_tune_formal_ref0.png')
#plt.savefig('em_tune_formal_ref1.png')
#plt.savefig('em_tune_formal_ref2.png')
#plt.savefig('em_tune_formal_ref3.png')
