import argparse
import sys, os, pdb
reload(sys)  
sys.setdefaultencoding('utf8')
import nltk
import re
import subprocess
import time

def has_expand_contractions(informal_sent, formal_sent, contractions_expansions):
    informal_sent = informal_sent.replace(' \'', '\'')
    informal_sent = informal_sent.replace(' n\'t', 'n\'t')
    formal_sent = formal_sent.replace(' \'', '\'')
    formal_sent = formal_sent.replace(' n\'t', 'n\'t')
    
    for contraction, expansion in contractions_expansions.iteritems():
        if contraction in informal_sent and expansion in formal_sent:
	    return True
    return False   

def has_capitalization_lowercasing(informal_sent, formal_sent):
    informal_words = informal_sent.split()
    formal_words = formal_sent.split()
    capitalization = False
    lowercasing = False
    for w1 in informal_words:
        for w2 in formal_words:
            if w1.lower() == w2.lower():
                if w1 != w2 and (w1.capitalize() == w2 or w1.upper() == w2):
                    capitalization = True
		if w1.upper() == w1 and w1 != w2:
		    lowercasing = True
	    if capitalization and lowercasing:
		return (capitalization, lowercasing)
    return (capitalization, lowercasing)

def has_punctuation_edits(informal_sent, formal_sent):
    if informal_sent.count('?') != formal_sent.count('?'):
	return True
    if informal_sent.count('!') != formal_sent.count('!'):
	return True
    if informal_sent.count('.') != formal_sent.count('.'):
	return True
    if informal_sent.count(',') != formal_sent.count(','):
	return True
    return False


def main(args):
    informal_sents = open(args.informal_sents_file, 'r').readlines()
    formal_sents = open(args.formal_sents_file, 'r').readlines()
    contractions_expansions_file = open(args.contractions_expansions_file, 'r')
    contractions_expansions = {}
    for line in contractions_expansions_file.readlines():
        contraction, expansion = line.strip('\n').split('\t')
        contractions_expansions[contraction] = expansion
    slangs_file = open(args.slangs_file, 'r')
    slangs = {}
    for line in slangs_file.readlines():
        s, l = line.strip('\n').split('\t')
        slangs[s] = l
    total = len(informal_sents)
    capitalizations = 0
    punctuation_edits = 0
    expand_contractions = 0
    normalize_slangs = 0
    lowercasing = 0
    for i in range(total):
	informal_sent = informal_sents[i].strip('\n').encode("ascii", "ignore")
	formal_sent = formal_sents[i].strip('\n').encode("ascii", "ignore")
	#informal_sent = ' '.join(nltk.word_tokenize(informal_sent))
	#formal_sent = ' '.join(nltk.word_tokenize(formal_sent))
	has_caps, has_lowers =  has_capitalization_lowercasing(informal_sent, formal_sent)
	if has_caps:
	    capitalizations += 1
	if has_lowers:
	    lowercasing += 1
        if has_punctuation_edits(informal_sent, formal_sent):
	    punctuation_edits += 1
	if has_expand_contractions(informal_sent, formal_sent, contractions_expansions):
	    expand_contractions += 1
	if has_expand_contractions(informal_sent, formal_sent, slangs):
	    normalize_slangs += 1
       
    print 'capitalizations %f' % (capitalizations*1.0/total)
    print 'punctuation_edits %f' % (punctuation_edits*1.0/total)
    print 'expand_contractions %f' % (expand_contractions*1.0/total)
    print 'normalize_slangs %f' % (normalize_slangs*1.0/total)
    print 'lowercasing %f' % (lowercasing*1.0/total)
    
if __name__ == "__main__":
    argparser = argparse.ArgumentParser(sys.argv[0])
    argparser.add_argument("--informal_sents_file", type = str)
    argparser.add_argument("--formal_sents_file", type = str)
    argparser.add_argument("--contractions_expansions_file", type = str)
    argparser.add_argument("--slangs_file", type = str)
    args = argparser.parse_args()
    print args
    print ""
    main(args)
