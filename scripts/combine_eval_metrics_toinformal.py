import sys
import numpy as np
def convert_score(A, B, a, b, x):
	return (B-A)*(x-a)*1.0/(b-a) + A

def get_combined_scores_human(formality_scores_file, fluency_scores_file, meaning_scores_file, combined_scores_file):
	all_sents_combined_scores = []
	for i in range(len(formality_scores_file)):
		formality_scores = formality_scores_file[i].split('\t')[1].split(',')
		fluency_scores = fluency_scores_file[i].split('\t')[1].split(',')
		meaning_scores = meaning_scores_file[i].split('\t')[1].split(',')
		sent = formality_scores_file[i].split('\t')[-1]
		if 'None' in formality_scores or 'None' in fluency_scores or 'None' in meaning_scores:
			combined_scores_file.write('None\t%s' % sent)
			continue
		formality_scores = [int(s)+4 for s in formality_scores]
		fluency_scores = [convert_score(1, 7, 1, 5, int(s)) for s in fluency_scores]
		meaning_scores = [convert_score(1, 7, 1, 6, int(s)+1) for s in meaning_scores]
		avg_formality_score = np.mean(formality_scores)
		avg_fluency_score = np.mean(fluency_scores)
		avg_meaning_score = np.mean(meaning_scores)
		#combined_score = (avg_formality_score+avg_fluency_score+avg_meaning_score)/3
		combined_score = (avg_formality_score+avg_fluency_score+avg_meaning_score*-1.0)/3
		combined_scores_file.write('%s\t%s' % (combined_score, sent))
		all_sents_combined_scores.append(combined_score)
	return all_sents_combined_scores

def get_combined_scores_auto(formality_scores_file, fluency_scores_file, meaning_scores_file, combined_scores_file):
	all_sents_combined_scores = []
	for i in range(len(formality_scores_file)):
		formality_score = formality_scores_file[i].split('\t')[0]
		fluency_score = fluency_scores_file[i].strip('\n')
		meaning_score = meaning_scores_file[i].strip('\n')
		formality_score = float(formality_score)+4
		fluency_score = convert_score(1, 7, 1, 5, float(fluency_score))
		meaning_score = convert_score(1, 7, 1, 6, float(meaning_score)+1)
		#combined_score = (formality_score+fluency_score+meaning_score)/3
		combined_score = (formality_score+fluency_score+meaning_score*-1.0)/3
		combined_scores_file.write('%s\n' % (combined_score))
		all_sents_combined_scores.append(combined_score)
	return all_sents_combined_scores

formality_scores_file = open(sys.argv[1]+'.formality.human', 'r').readlines()
fluency_scores_file = open(sys.argv[1]+'.fluency.human','r').readlines()
meaning_scores_file = open(sys.argv[1]+'.meaning.human', 'r').readlines()
combined_scores_file = open(sys.argv[1]+'.combined.human', 'w')
combined_scores_human = get_combined_scores_human(formality_scores_file, fluency_scores_file, meaning_scores_file, combined_scores_file)
print 'Human: Avg Combined Score %f' % np.mean(combined_scores_human)

formality_scores_file = open(sys.argv[1]+'.formality.predictions', 'r').readlines()
fluency_scores_file = open(sys.argv[1]+'.fluency.predictions','r').readlines()
meaning_scores_file = open(sys.argv[1]+'.meaning.predictions.sts', 'r').readlines()
combined_scores_file = open(sys.argv[1]+'.combined.predictions', 'w')
combined_scores_auto = get_combined_scores_auto(formality_scores_file, fluency_scores_file, meaning_scores_file, combined_scores_file)
print 'Automatic: Avg Combined Score %f' % np.mean(combined_scores_auto)

