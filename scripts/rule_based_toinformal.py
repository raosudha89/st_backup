import argparse
import sys, os, pdb
reload(sys)  
sys.setdefaultencoding('utf8')
import nltk
import re
import subprocess
import time
from collections import defaultdict
import random

def apply_rules(sentence, rules):
    #sentence = sentence.replace(' \'', '\'')
    #sentence = sentence.replace(' n\'t', 'n\'t')
    for (expansion, contraction) in rules:
	sentence = sentence.replace(' '+expansion+' ', ' '+contraction+' ')
    return sentence

def main(args):
    informal_train_file = open(args.informal_train_file, 'r')
    total = 0
    all_caps = 0
    all_caps_word_dict = defaultdict(int)
    repeated_char_words = defaultdict(int)
    repeated_char = {}
    word_dict = defaultdict(int)
    punctuations = {'?':0, '.':0, '!':0}
    for line in informal_train_file.readlines():
	original_sentence = line.strip('\n')
	total += 1
	is_all_caps = False
	if original_sentence == original_sentence.upper():
	    is_all_caps = True
	    all_caps += 1
	for w in nltk.word_tokenize(original_sentence):
	    if len(w) > 1 and w.isalpha() and not is_all_caps:
		if w == w.upper():
		    all_caps_word_dict[w.lower()] += 1
		word_dict[w.lower()] += 1
	    	if 'www.' not in w:
		    repeats = re.findall(r'((\w)\2{2,})', w)
		    for (repeat, single) in repeats:
			norm_word = w.replace(repeat, single).lower()
		        repeated_char_words[norm_word] += 1
			if word_dict[norm_word] == 0:
			    word_dict[norm_word] += 1
		        repeated_char[norm_word] = single.lower()
        for p in punctuations:
	    if original_sentence.count(p) > 2:
		punctuations[p] += 1

    all_caps_dist = [1]*(int(all_caps*100.0/total)) + [0]*(100-int(all_caps*100.0/total))
    all_caps_word_dist = {}
    for w in all_caps_word_dict:
        c = int(all_caps_word_dict[w]*100.0/word_dict[w])
	all_caps_word_dist[w] = [1]*c + [0]*(100-c)
    repeated_char_word_dist = {}
    for w in repeated_char_words:
	c = int(repeated_char_words[w]*100.0/word_dict[w])
	repeated_char_word_dist[w] = [1]*c + [0]*(100-c)
    punctuations_dist = {}
    for p in punctuations:
	c = int(punctuations[p]*100.0/total)
	punctuations_dist[p] = [1]*c + [0]*(100-c)

    sentences_file = open(args.sentences_file, 'r')
    rules_file = open(args.rules_file, 'r')
    rules = []
    for line in rules_file.readlines():
        contraction, expansion = line.strip('\n').split('\t')
        rules.append((expansion, contraction))
    output_file = open(args.output_file, 'w')
    for line in sentences_file.readlines():
        original_sentence = line.strip('\n')
        original_sentence = original_sentence.encode("ascii", "ignore")
        words = [w.lower() for w in nltk.word_tokenize(original_sentence)]
        sentence = ' '.join(words)
        sentence = apply_rules(sentence, rules)
       	if random.choice(all_caps_dist):
	    sentence = sentence.upper()
	words = sentence.split()
	for i in range(len(words)):
	    if words[i] in all_caps_word_dist:
		if random.choice(all_caps_word_dist[words[i]]):
		    words[i] = words[i].upper()
	    if len(words[i]) > 1 and words[i] in repeated_char_word_dist:
		if random.choice(repeated_char_word_dist[words[i]]):
		    c = repeated_char[words[i]]
		    words[i] = words[i].replace(c, c+c+c+c+c) 
	sentence = ' '.join(words)
	for p in punctuations_dist:
	    if p in sentence and random.choice(punctuations_dist[p]):
		sentence = sentence.replace(p, p+p+p+p+p) 
        output_file.write(sentence+'\n')
    output_file.close()
    sentences_file.close()
    rules_file.close()
        
if __name__ == "__main__":
    argparser = argparse.ArgumentParser(sys.argv[0])
    argparser.add_argument("--informal_train_file", type = str)
    argparser.add_argument("--sentences_file", type = str)
    argparser.add_argument("--rules_file", type = str)
    argparser.add_argument("--output_file", type = str)
    args = argparser.parse_args()
    print args
    print ""
    main(args)
