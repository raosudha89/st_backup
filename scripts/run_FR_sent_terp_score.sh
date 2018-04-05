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

python to_terp_format.py $ref_file
split -l 1 $ref_file $ref_prefix.
split -l 1 $ref_file.terpformat $ref_prefix.terpformat.

for file in "${files[@]}"; do
	split_prefix=/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval/sent_splits/$(basename $file)
	split -l 1 $file $split_prefix.
	split -l 1 $file.terpformat $split_prefix.terpformat.
	for i in {a..t}; do
		for j in {a..z}; do 
			bin/terp -r $ref_prefix.$i$j.terpformat -h $split_prefix.terpformat.$i$j > $split_prefix.$i$j.terp_score.full
			tail -1 $split_prefix.$i$j.terp_score.full > $split_prefix.$i$j.terp_score
		done
	done
	for i in {g..z}; do
		rm $split_prefix.t$i.terp_score
	done
	cat $split_prefix.*.terp_score > $file.sent_terp_scores
done
