import sys, pdb
import csv
from random import shuffle

if __name__ == '__main__':
    informal_sentences_file = open(sys.argv[1])
    formal_sentences_file = open(sys.argv[2])
    csv_file = open(sys.argv[3], 'w')
    csv_file.write('sentence_1a,sentence_1b,sentence_2a,sentence_2b,sentence_3a,sentence_3b,sentence_4a,sentence_4b,sentence_5a,sentence_5b\n')
    i = 0
    informal_sentences = informal_sentences_file.readlines()
    formal_sentences = formal_sentences_file.readlines()
    sentence_pairs = []
    for i in range(len(informal_sentences)):
        sentence_pairs.append((informal_sentences[i].strip('\n'), formal_sentences[i].strip('\n')))
    shuffle(sentence_pairs)
    total = len(sentence_pairs)/5
    for i in range(total):
        line = ''
        for j in range(5):
            try:
                line += '\"' + sentence_pairs[i*5+j][0].replace('\"','\'') + '\",\"' + sentence_pairs[i*5+j][1].replace('\"','\'') + '",'
            except:
                pdb.set_trace()
        line = line[:-1] #remove last comma
        csv_file.write(line + '\n')
