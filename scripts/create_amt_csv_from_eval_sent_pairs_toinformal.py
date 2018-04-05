import sys, pdb
import csv
from random import shuffle

def get_sentno_model_dict(sentences_file):
    sentno_model_dict = {}
    for line in sentences_file.readlines():
        sentno_model, sent = line.split('\t')
        sent = sent.strip('\n')
        sentno, model = sentno_model.split('_', 1)
        sentno = int(sentno)
        if model in ['ref0', 'ref1', 'ref2', 'ref3']:
            model = 'ref'
            sentno += 1 # Buggy fix since ref sentno are off by -1
        if model not in sentno_model_dict:
            sentno_model_dict[model] = {}
        sentno_model_dict[model][sentno] = sent
    return sentno_model_dict 

if __name__ == '__main__':
    formal_sentences_file = open(sys.argv[1]) #Only 500 source formal sentences
    informal_sentences_file = open(sys.argv[2]) #All model outputs + ref formal sentences i.e. 3000 sents

    formality_csv_file = open(sys.argv[3], 'w')
    formality_csv_file.write('id_1,sentence_1,id_2,sentence_2,id_3,sentence_3,id_4,sentence_4,id_5,sentence_5\n')
    fluency_csv_file = open(sys.argv[4], 'w')
    fluency_csv_file.write('id_1,sentence_1,id_2,sentence_2,id_3,sentence_3,id_4,sentence_4,id_5,sentence_5\n')
    meaning_csv_file = open(sys.argv[5], 'w')
    meaning_csv_file.write('id_1a,sentence_1a,id_1b,sentence_1b,'+ \
                           'id_2a,sentence_2a,id_2b,sentence_2b,' + \
                           'id_3a,sentence_3a,id_3b,sentence_3b,' + \
                           'id_4a,sentence_4a,id_4b,sentence_4b,' + \
                           'id_5a,sentence_5a,id_5b,sentence_5b\n')

    formal_sentno_model_dict = get_sentno_model_dict(formal_sentences_file)
    informal_sentno_model_dict = get_sentno_model_dict(informal_sentences_file) 
    all_sentences = []
    for sentno in formal_sentno_model_dict['org_formal']:
        sent = formal_sentno_model_dict['org_formal'][sentno]
	all_sentences.append((str(sentno) + '_org_formal', sent))
    for model in informal_sentno_model_dict:
        for sentno in informal_sentno_model_dict[model]:
	    sent = informal_sentno_model_dict[model][sentno]
            all_sentences.append((str(sentno) + '_' + model, sent))
    shuffle(all_sentences)
    output_line = ''
    for i in range(len(all_sentences)):
        id, sentence = all_sentences[i]
        if i%5 == 0 and i != 0:
            output_line = output_line[:-1] #remove last comma
            formality_csv_file.write(output_line + '\n')
            fluency_csv_file.write(output_line + '\n')
            output_line = ''
        output_line += id + ',' + '\"' + sentence.replace('\"','') + '",'
    # Add the last line
    output_line = output_line[:-1] #remove last comma
    formality_csv_file.write(output_line + '\n')
    fluency_csv_file.write(output_line + '\n')
    output_line = ''
    
    formal_informal_sentences = []
    for model in informal_sentno_model_dict:
        for sentno in informal_sentno_model_dict[model]:
            formal_id = str(sentno) + '_org_formal'
            formal_sent = formal_sentno_model_dict['org_formal'][sentno]
            informal_id = str(sentno) + '_' + model
            informal_sent = informal_sentno_model_dict[model][sentno]
            formal_informal_sentences.append(((formal_id, formal_sent), (informal_id, informal_sent)))
    shuffle(formal_informal_sentences)
    for i in range(len(formal_informal_sentences)):
        ((id_a, formal_sentence), (id_b, informal_sentence)) = formal_informal_sentences[i]
        if i%5 == 0 and i != 0:
            output_line = output_line[:-1] #remove last comma
            meaning_csv_file.write(output_line+'\n')
            output_line = ''
        output_line += id_a + ',' + '"' + formal_sentence.replace('\"', '') + '",' + \
                        id_b + ',' + '"' + informal_sentence.replace('\"', '') + '",'
    output_line = output_line[:-1] #remove last comma
    meaning_csv_file.write(output_line+'\n')
        
