import sys, pdb
import csv
import numpy
from collections import defaultdict

def to_float_judgement(judgement):
    convert = {'Very Informal': -3, 'Informal': -2, 'Somewhat Informal': -1, 'Neutral': 0, 'Somewhat Formal': 1, 'Formal': 2, 'Very Formal': 3}
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
            print row[27:37]
            print row[38:43]
            i += 1
            continue
        for i in range(27, 37, 2):
            id, sent = row[i], row[i+1]
            no = id[:-1]
            no = int(no)-1
            model_sentences[int(no)] = sent
            
            if not model_sentence_judgements[int(no)]:
                model_sentence_judgements[int(no)] = []
            if row[38+(i-27)/2] != '':
                model_sentence_judgements[no].append(to_float_judgement(row[38+(i-27)/2]))
    
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
            
