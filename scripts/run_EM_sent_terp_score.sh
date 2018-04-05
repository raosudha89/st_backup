#!/bin/bash

declare -a files=(
	#"/corpora/yahoo_answers/final_data/Entertainment_Music/test/final_human_eval/answers.Entertainment_Music.sents.batch040.org.tok.informal.part1" 
	"/corpora/yahoo_answers/final_data/Entertainment_Music/test/final_human_eval/answers.Entertainment_Music.sents.batch040.tok.informal.part1" 
	"/corpora/yahoo_answers/final_data/Entertainment_Music/test/final_human_eval/answers.Entertainment_Music.sents.batch040.filtered.selftraining6x.gt10editdist.lm_All_gt_0.smt.formal.part1" 
	"/corpora/yahoo_answers/final_data/Entertainment_Music/test/final_human_eval/answers.Entertainment_Music.sents.batch040.model.50K_epoch14_29.77.formal.part1" 
	"/corpora/yahoo_answers/final_data/Entertainment_Music/test/final_human_eval/answers.Entertainment_Music.sents.batch040.selftraining10x.usingnmtbacktranslate.nmtbpe.usinglm_epoch8_25.80.formal.part1" 
	);

ref_file=/corpora/yahoo_answers/final_data/Entertainment_Music/test/final_human_eval/answers.Entertainment_Music.sents.batch040.tok.formal.filtered.ref0_1_2_3.part1
ref_prefix=/corpora/yahoo_answers/final_data/Entertainment_Music/test/final_human_eval/sent_splits/answers.Entertainment_Music.sents.batch040.tok.formal.filtered.ref0_1_2_3.part1

#python to_terp_format.py $ref_file
 
#split -l 1 $ref_file $ref_prefix.
#split -l 1 $ref_file.terpformat $ref_prefix.terpformat.

for file in "${files[@]}"; do
	python to_terp_format.py $file
	split_prefix=/corpora/yahoo_answers/final_data/Entertainment_Music/test/final_human_eval/sent_splits/$(basename $file)
	split -l 1 $file $split_prefix.
	split -l 1 $file.terpformat $split_prefix.terpformat.
	for i in {a..t}; do
		for j in {a..z}; do 
			bin/terp -r $ref_prefix.terpformat.$i$j -h $split_prefix.terpformat.$i$j > $split_prefix.$i$j.terp_score.full
			tail -1 $split_prefix.$i$j.terp_score.full > $split_prefix.$i$j.terp_score
		done
	done
	for i in {g..z}; do
		rm $split_prefix.t$i.terp_score
	done
	cat $split_prefix.*.terp_score > $file.sent_terp_scores
done
