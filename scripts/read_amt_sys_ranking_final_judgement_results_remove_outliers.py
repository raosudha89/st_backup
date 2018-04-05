import sys, pdb
import csv
import numpy
import matplotlib.pyplot as plt
from collections import defaultdict
import scipy.stats as ss

def remove_outliers(judgments):
    min_rank = min(judgments)
    max_rank = max(judgments)
    judgments.remove(min_rank)
    judgments.remove(max_rank)
    #if judgments.count(min_rank) == 1 and min_rank in [1]:
    #	judgments.remove(min_rank)
    #if judgments.count(max_rank) == 1 and max_rank in [6]:
    #    judgments.remove(max_rank)
    return judgments

if __name__ == '__main__':
    results_csv = open(sys.argv[1])
    results_reader = csv.reader(results_csv, delimiter=',')
    output_prefix = sys.argv[2]
    
    i = 0
    model_sentence_judgements = {}
    sentence_model_judgements = {}
    model_sentences = {}
    for row in results_reader:
        if i == 0:
            print row[27:46]
            i += 1
            continue
        judgments = row[40:46]
        ranks = []
        for judgment in judgments:
            if judgment == '':
                ranks.append(None)
            else:
                ranks.append(int(judgment.split('_')[1]))
        ranks = ss.rankdata(ranks, method='dense')
        informal = row[27]
        for i in range(28, 40, 2):
            id, formal = row[i], row[i+1]
            sent_no, model = id.split('_', 1)
            if model in ['ref0', 'ref1', 'ref2', 'ref3']:
                model = 'ref'
            sent_no = int(sent_no)-1
            if model not in model_sentence_judgements:
                model_sentences[model] = [None]*500
                model_sentence_judgements[model] = [None]*500
            model_sentences[model][int(sent_no)] = formal
             
            if not model_sentence_judgements[model][sent_no]:
                model_sentence_judgements[model][sent_no] = []
            
            # if sent_no not in sentence_model_judgements:
            #     sentence_model_judgements[sent_no] = [None]*5
                
            rank = ranks[(i-28)/2]
            if rank:
                model_sentence_judgements[model][sent_no].append(rank)
    
            # sentence_model_judgements[sent_no][model_to_no[model]] = rank
    
    for model in model_sentence_judgements:
        print model
        output_file = open(output_prefix+'.' +model, 'w')
        mean_sent_judgements = []
        for no in range(500):
            if model_sentence_judgements[model][no]:
		model_sentence_judgements[model][no] = remove_outliers(model_sentence_judgements[model][no])
                mean_sent_judgement = numpy.mean(model_sentence_judgements[model][no])
                mean_sent_judgements.append(mean_sent_judgement)
            else:
                output_file.write('None\tNone,None,None,None,None\t%s\n' % (model_sentences[model][no]))
                continue
            line = '%.2f\t' % (mean_sent_judgement)
            line += str(model_sentence_judgements[model][no][0])
            for val in model_sentence_judgements[model][no][1:]:
                line += ',' + str(val)
            line += '\t' + model_sentences[model][no]
            output_file.write(line+'\n')
        
        # print model
        # mean_sent_judgements = []
        # output_file = open(output_prefix+'.' +model+'.human.ranking', 'w')
        # for no in range(500):
        #     if model_sentence_judgements[model][no]:
        #         mean_sent_judgement = numpy.mean(model_sentence_judgements[model][no])
        #         mean_sent_judgements.append(mean_sent_judgement)
        #         output_file.write(str(mean_sent_judgement))
                
        print numpy.mean(mean_sent_judgements)
        
    # for sent_no, ranks in sentence_model_judgements.iteritems():
    #     sentence_model_judgements[sent_no] = ss.rankdata(ranks, method='dense')
    # 
    # for model_no in range(5):
    #     print models[model_no]
    #     mean_model_judgements = []
    #     for sent_no in range(1,499):
    #         if sent_no not in sentence_model_judgements.keys():
    #             print 'Missing sentence %d' % sent_no
    #             continue
    #         mean_model_judgements.append(sentence_model_judgements[sent_no][model_no])
    #     print numpy.mean(mean_model_judgements)
    
