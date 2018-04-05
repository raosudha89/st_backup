import matplotlib
matplotlib.use('Agg')
import sys
import matplotlib.pyplot as plt
import numpy as np

prefix_EM="/corpora/yahoo_answers/final_data/Entertainment_Music/test/final_human_eval_v2/answers.Entertainment_Music.sents.batch040"
prefix_FR="/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval_v2/answers.Family_Relationships.sents.batch0040"
files_EM=[\
	"tok.formal.filtered.ref0_1_2_3",\
	"tok.informal",\
	"filtered.selftraining6x.gt10editdist.lm_All_gt_0.smt.formal",\
	"tok.nmt.50K.ansemb.formal",\
	"tok.nmt.50K.ansemb.copy.formal",\
	"tok.nmt.50K.ansemb.copy.selftraining6x.gt10editdist.nmtbacktranslate.formal"\
	]
files_FR=[\
	"filtered.tok.formal.ref0_1_2_3",\
	"tok.informal",\
	"filtered.selftraining10x.gt0editdit.lm_All_gt_0.smt.formal",\
	"tok.nmt.50K.ansemb.formal",\
	"tok.nmt.50K.ansemb.copy.formal",\
	"tok.nmt.50K.ansemb.copy.selftraining10x.gt10editdist.nmtbacktranslate.formal",\
	]
models=["Formal Reference", "Rule Based", "PBMT Combined", "NMT Baseline", "NMT Copy", "NMT Combined"]

def get_editdists(input_file):
	editdists = []
	for line in input_file.readlines():
		editdists.append(int(line.strip('\n')))
	return editdists

def get_scores(input_file):
	scores = []
	for line in input_file.readlines():
		scores.append(line.split('\t')[0])
	return scores

def get_histogram_scores(editdists, scores, bins):
	bin_counts = [0]*(len(bins)-1)
	bin_scores = [0]*(len(bins)-1)
	for j in range(len(editdists)):
		v = editdists[j]
		score = scores[j]
		if score == 'None':
			continue
		score = float(score)
		for i in range(len(bins)-1):
			if i < len(bins)-2:
				if v >= bins[i] and v < bins[i+1]:
					bin_counts[i] += 1
					bin_scores[i] += score
			else:
				if v >= bins[i] and v <= bins[i+1]:
					bin_counts[i] += 1
					bin_scores[i] += score

	bin_dist = [bin_scores[i]*1.0/bin_counts[i] for i in range(len(bin_counts))]
	return bin_dist

metric="formality.human"
#metric="fluency.human"
#metric="meaning.human"

bins = []
incr = 10
v = 0
while v <= 60:
	bins.append(v)
	v += incr 

formal_bin_dists = [None]*len(models)
header_line = 'Bins'
for i in range(len(models)):
	formal_editdist_file = open(prefix_EM+'.'+files_EM[i]+'.part1.editdist', 'r')
	formal_editdists = get_editdists(formal_editdist_file)
	formal_file = open(prefix_EM+'.'+files_EM[i]+'.part1.'+metric, 'r')	
	formal_scores = get_scores(formal_file)
	formal_bin_dists[i] = get_histogram_scores(formal_editdists, formal_scores, bins)
	header_line += '\tScore\t'+models[i]
header_line += '\n'

output_file = open(prefix_EM+'.part1.'+metric+'.editdist.plot.tsv', 'w')
output_file.write(header_line)

for i in range(len(bins)-1):
	line = '[%s,%s)' % (bins[i], bins[i+1])
	for j in range(len(models)):
		line += '\t%s\t%s' % (bins[i], formal_bin_dists[j][i])
	output_file.write(line+'\n')

