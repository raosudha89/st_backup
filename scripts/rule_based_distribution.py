import argparse
import sys, os, pdb
reload(sys)  
sys.setdefaultencoding('utf8')
import nltk
import re
import subprocess
import time
from collections import defaultdict
from string import ascii_lowercase

def main(args):
    sentences_file = open(args.sentences_file, 'r')
    total = 0
    all_caps = 0
    punctuations = {'?':0, '.':0, '!':0}
    all_caps_dict = defaultdict(int)
    repeated_char_words = defaultdict(int)
    for line in sentences_file.readlines():
	total += 1
        original_sentence = line.strip('\n')
        original_sentence = original_sentence.encode("ascii", "ignore")
	is_all_caps = False
	if original_sentence == original_sentence.upper():
	    all_caps += 1
	    is_all_caps = True
	for w in nltk.word_tokenize(original_sentence):
	    if len(w) > 1 and not w.isdigit():
		if  w == w.upper() and not is_all_caps:
		    all_caps_dict[w] += 1
	        if 'www.' not in w and re.findall(r'((\w)\2{2,})', w):
		    repeated_char_words[w] += 1
        for p in punctuations:
	    if original_sentence.count(p) > 2:
		punctuations[p] += 1
    #print all_caps*100.0/total
    #for w in all_caps_dict:
    #	if all_caps_dict[w]*100.0/total > 0.02:
    #	    print w, all_caps_dict[w]

    #for w in repeated_char_words:
    #	if repeated_char_words[w] > 1:
    #	    print w, repeated_char_words[w]

    print punctuations
    sentences_file.close()
        
if __name__ == "__main__":
    argparser = argparse.ArgumentParser(sys.argv[0])
    argparser.add_argument("--sentences_file", type = str)
    args = argparser.parse_args()
    print args
    print ""
    main(args)
