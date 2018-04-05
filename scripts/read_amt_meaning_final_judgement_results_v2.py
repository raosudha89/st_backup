import sys, pdb
import csv
import numpy
from collections import defaultdict

def to_float_judgement(judgement):
    convert = {'score_5':5, 'score_4':4, 'score_3':3, 'score_2':2, 'score_1':1, 'score_0':0}
    return convert[judgement]

if __name__ == '__main__':
    results_csv = open(sys.argv[1])
    results_reader = csv.reader(results_csv, delimiter=',')
    output_tsv_file = open(sys.argv[2], 'w')
    
    i = 0
    model_sentences = [None]*500
    model_sentence_judgements = [None]*500
    for row in results_reader:
        if i == 0:
            print row[27:47]
            print row[47:53]
            i += 1
            continue
        for i in range(27, 47, 4):
            id_a, sent = row[i], row[i+1]
            id_b, sent_b = row[i+2], row[i+3]
	    assert(id_a[:-1] == id_b[:-1])
            no = id_a[:-1]
            no = int(no)-1
            sent = sent_b
            model_sentences[int(no)] = sent
            if not model_sentence_judgements[int(no)]:
                model_sentence_judgements[int(no)] = []
            if row[47+(i-27)/4] != '':
                model_sentence_judgements[no].append(to_float_judgement(row[47+(i-27)/4]))
    
    for no in range(500):
            if model_sentence_judgements[no]:
                mean_judgement = numpy.mean(model_sentence_judgements[no])
            else:
                output_tsv_file.write('None\tNone,None,None\t%s\n' % (model_sentences[no]))
                continue
            line = '%.2f\t' % (mean_judgement)
            line += str(model_sentence_judgements[no][0])
            for val in model_sentence_judgements[no][1:]:
                line += ',' + str(val)
            line += '\t' + model_sentences[no]
            output_tsv_file.write(line+'\n')
            
