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

informal_file = open(sys.argv[1], 'r')
formal_ref0_file = open(sys.argv[2], 'r')
formal_ref1_file = open(sys.argv[3], 'r')
formal_ref2_file = open(sys.argv[4], 'r')
formal_ref3_file = open(sys.argv[5], 'r')
informal_formalities = get_formalities(informal_file)
formal_ref0_formalities = get_formalities(formal_ref0_file)
formal_ref1_formalities = get_formalities(formal_ref1_file)
formal_ref2_formalities = get_formalities(formal_ref2_file)
formal_ref3_formalities = get_formalities(formal_ref3_file)
bins = np.linspace(-3, 3, 60)
import pdb
pdb.set_trace()
y,binEdges=np.histogram(formal_ref0_formalities,bins)
bincenters = 0.5*(binEdges[1:]+binEdges[:-1])
plt.plot(bincenters,y,'-')
plt.savefig('em_tune_formal_ref0.png')

#data = np.vstack([informal_formalities, formal_ref0_formalities, formal_ref1_formalities, formal_ref2_formalities, formal_ref3_formalities]).T
#bins = np.linspace(-3, 3, 6)
#plt.hist(data, bins, alpha=0.7, label=['Informal', 'Formal Ref1', 'Formal Ref2', 'Formal Ref3'])
#plt.legend(loc='upper right')

#plt.hist(formal_ref0_formalities, bins)
#plt.savefig('em_tune_formal_ref0.png')
#plt.hist(formal_ref1_formalities, bins)
#plt.savefig('em_tune_formal_ref1.png')
#plt.hist(formal_ref2_formalities, bins)
#plt.savefig('em_tune_formal_ref2.png')
#plt.hist(formal_ref3_formalities, bins)
#plt.savefig('em_tune_formal_ref3.png')
