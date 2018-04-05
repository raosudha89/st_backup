#!/bin/bash

declare -a files=(
		#"/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval/answers.Family_Relationships.sents.batch0040.org.tok.informal.part1" 
		"/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval/answers.Family_Relationships.sents.batch0040.tok.informal.part1" 
		"/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval/answers.Family_Relationships.sents.batch0040.filtered.selftraining10x.gt0editdit.lm_All_gt_0.smt.formal.part1" 
		"/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval/answers.Family_Relationships.sents.batch0040.filtered.model.50K_epoch13_13.89.formal.part1" 
		"/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval/answers.Family_Relationships.sents.batch0040.filtered.smt.Family_Relationships.model.selftraining10x.usingnmtbacktranslate.nmtbpe.usinglm_epoch5_15.21.formal.part1" 
		); 

ref_file=/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval/answers.Family_Relationships.sents.batch0040.filtered.tok.formal.ref0_1_2_3.part1

ref_prefix=/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval/sent_splits/answers.Family_Relationships.sents.batch0040.filtered.tok.formal.ref0_1_2_3.part1

split -l 1 $ref_file $ref_prefix.

for file in "${files[@]}"; do
	split_prefix=/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval/sent_splits/$(basename $file)
	split -l 1 $file $split_prefix.
	for i in {a..t}; do
		for j in {a..z}; do 
			perl /projects/style_transfer/Shakespearizing-Modern-English/code/main/PINC.perl $ref_prefix.$i$j < $split_prefix.$i$j > $split_prefix.$i$j.pinc_score
		done
	done
	cat $split_prefix.*.pinc_score > $file.sent_pinc_scores
done
