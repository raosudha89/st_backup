import sys, pdb
import csv
from collections import defaultdict

if __name__ == '__main__':
    results_csv = open(sys.argv[1])
    results_reader = csv.DictReader(results_csv, delimiter=',')
    formal_file = open(sys.argv[2], 'w')
    informal_file_ref1 = open(sys.argv[3]+'0', 'w')
    informal_file_ref2 = open(sys.argv[3]+'1', 'w')
    informal_file_ref3 = open(sys.argv[3]+'2', 'w')
    informal_file_ref4 = open(sys.argv[3]+'3', 'w')
    sentence_judgements = {}
    i = 0
    sentences_in_order = []
    too_short = 0
    missing = 0
    rewrites = {}
    informals = {}
    for row in results_reader:
	HITId = row['HITId']
        try:
            rewrites[HITId]
        except:
            rewrites[HITId] = defaultdict(list)
	    informals[HITId] = {}
	informal_sentences = [None]*5
	formal_sentences = [None]*5
	informal_rewrites = [None]*5
        informal_sentences[0] = row['Input.sentence_1a']
        informal_sentences[1] = row['Input.sentence_2a']
        informal_sentences[2] = row['Input.sentence_3a']
        informal_sentences[3] = row['Input.sentence_4a']
        informal_sentences[4] = row['Input.sentence_5a']
	formal_sentences[0] = row['Input.sentence_1b']
	formal_sentences[1] = row['Input.sentence_2b']
	formal_sentences[2] = row['Input.sentence_3b']
	formal_sentences[3] = row['Input.sentence_4b']
	formal_sentences[4] = row['Input.sentence_5b']
	informal_rewrites[0] = row['Answer.sentence_1']
	informal_rewrites[1] = row['Answer.sentence_2']
	informal_rewrites[2] = row['Answer.sentence_3']
	informal_rewrites[3] = row['Answer.sentence_4']
	informal_rewrites[4] = row['Answer.sentence_5']
        for j in range(5):
            formal = formal_sentences[j].strip('\n')
            informal = informal_rewrites[j].strip('\n')
            if informal.strip() == '{}':
                missing += 1
                continue
            #informal_basic = informal.replace('!', '').replace('.', '').replace('?','')
            #Ignore if the rewrite into formal is too short
            # i.e. ratio between (informal-formal)/informal is 
            if (len(formal.split()) - len(informal.split()))*1.0/len(formal.split()) > 0.5:
		too_short += 1
                continue
            rewrites[HITId][formal].append(informal)
	    informals[HITId][formal] = informal_sentences[j].strip('\n')

    print '# of too short rewrites: %d' % too_short
    print '# of missing rewrites %d' % missing
    for HITId in rewrites:
        for formal in rewrites[HITId]:
            if len(rewrites[HITId][formal]) < 3:
                continue
            formal_file.write(formal+'\n')
            informal_file_ref1.write(informals[HITId][formal]+'\n')
            informal_file_ref2.write(rewrites[HITId][formal][0]+'\n')
            informal_file_ref3.write(rewrites[HITId][formal][1]+'\n')
            informal_file_ref4.write(rewrites[HITId][formal][2]+'\n')
