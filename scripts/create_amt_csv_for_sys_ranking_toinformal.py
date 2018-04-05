import sys
import random

formal_file = open(sys.argv[1], 'r')
formal_sents = formal_file.readlines()
model_sents = [None]*6
for i in range(2, 8):
	model_sents[i-2] = open(sys.argv[i], 'r').readlines()
output_csv_file = open(sys.argv[8], 'w')
output_csv_file.write('formal_sentence,id_1,informal_1,id_2,informal_2,id_3,informal_3,id_4,informal_4,id_5,informal_5,id_6,informal_6\n')
for i in range(len(formal_sents)):
	formal_sent = '\"'+formal_sents[i].strip('\n').split('\t')[1].replace('\"', '')+'\"'
	informal_id_sents = []
	for j in range(6):
		id, sent = model_sents[j][i].split('\t')
		sentno, model = id.split('_', 1)
		if model in ['ref0', 'ref1', 'ref2', 'ref3']:
			id = str(int(sentno)+1) + '_ref' #Buggy fix since ref is off by -1
		sent = '\"'+sent.strip('\n').replace('\"', '')+'\"'
		informal_id_sents.append((id, sent))
	random.shuffle(informal_id_sents)
	output_csv_file.write(formal_sent+','+ \
				informal_id_sents[0][0]+','+informal_id_sents[0][1]+','+\
				informal_id_sents[1][0]+','+informal_id_sents[1][1]+','+\
				informal_id_sents[2][0]+','+informal_id_sents[2][1]+','+\
				informal_id_sents[3][0]+','+informal_id_sents[3][1]+','+\
				informal_id_sents[4][0]+','+informal_id_sents[4][1]+','+\
				informal_id_sents[5][0]+','+informal_id_sents[5][1]+'\n')
