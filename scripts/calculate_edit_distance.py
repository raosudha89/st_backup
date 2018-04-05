import sys, pdb
import editdistance

if __name__ == "__main__":
	model1_file = open(sys.argv[1], 'r')
	model2_file = open(sys.argv[2], 'r')
	model1_sents = model1_file.readlines()
	model2_sents = model2_file.readlines()
	total_dist = 0
	N = len(model1_sents)
	for i in range(N):
		total_dist += editdistance.eval(model1_sents[i], model2_sents[i])
	print total_dist*1.0/N
