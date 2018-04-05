import sys
import random

informal_file = open(sys.argv[1], 'r')
informal_sents = informal_file.readlines()
model_sents = [None]*6
for i in range(2, 6):
	model_sents[i-2] = open(sys.argv[i], 'r').readlines()
output_csv_file = open(sys.argv[6], 'w')
output_csv_file.write('informal_sentence,id_1,formal_1,id_2,formal_2,id_3,formal_3,id_4,formal_4\n')
for i in range(len(informal_sents)):
	informal_sent = '\"'+informal_sents[i].strip('\n').split('\t')[1].replace('\"', '')+'\"'
	formal_id_sents = []
	for j in range(4):
		id, sent = model_sents[j][i].split('\t')
		sent = '\"'+sent.strip('\n').replace('\"', '')+'\"'
		formal_id_sents.append((id, sent))
	random.shuffle(formal_id_sents)
	output_csv_file.write(informal_sent+','+ \
				formal_id_sents[0][0]+','+formal_id_sents[0][1]+','+\
				formal_id_sents[1][0]+','+formal_id_sents[1][1]+','+\
				formal_id_sents[2][0]+','+formal_id_sents[2][1]+','+\
				formal_id_sents[3][0]+','+formal_id_sents[3][1]+'\n')
