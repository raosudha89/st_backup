import sys
import random

ref0 = open(sys.argv[1], 'r')
ref1 = open(sys.argv[2], 'r')
ref2 = open(sys.argv[3], 'r')
ref3 = open(sys.argv[4], 'r')
ref_sents = [None]*4
ref_sents[0] = ref0.readlines()
ref_sents[1] = ref1.readlines()
ref_sents[2] = ref2.readlines()
ref_sents[3] = ref3.readlines()
N = len(ref_sents[0])
ref0_1_2_3 = open(sys.argv[5], 'w')
ref0_1_2_3_withindices = open(sys.argv[6], 'w')
#rand = [0]*N/4 + [1]*N/4 + [2]*N/4 + [3]*N/4
#rand = random.shuffle(rand)
for i in range(N):
	j = random.randint(0,3)
	s = ref_sents[j][i]
	ref0_1_2_3.write(s)
	ref0_1_2_3_withindices.write('%s_ref%s\t%s' % (i, j, s))
