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

split -l 1 $ref_file $ref_prefix.
#split -l 1 $ref_file.terpformat $ref_prefix.terpformat.

for file in "${files[@]}"; do
	split_prefix=/corpora/yahoo_answers/final_data/Entertainment_Music/test/final_human_eval/sent_splits/$(basename $file)
	split -l 1 $file $split_prefix.
	for i in {a..t}; do
		for j in {a..z}; do 
			perl /projects/style_transfer/Shakespearizing-Modern-English/code/main/PINC.perl $ref_prefix.$i$j < $split_prefix.$i$j > $split_prefix.$i$j.pinc_score 
		done
	done
	cat $split_prefix.*.pinc_score > $file.sent_pinc_scores
done
