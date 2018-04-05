import sys, pdb
import editdistance

if __name__ == "__main__":
	informal_file = open(sys.argv[1], 'r')
	formal_file = open(sys.argv[2], 'r')
	editdist_formal_file = open(sys.argv[2]+'.editdist', 'w')
	informal_sents = informal_file.readlines()
	formal_sents = formal_file.readlines()
	for i in range(len(informal_sents)):
		dist = editdistance.eval(informal_sents[i], formal_sents[i])
		editdist_formal_file.write(str(dist)+'\n')
