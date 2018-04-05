#prefix=/corpora/yahoo_answers/final_data/Family_Relationships/test/answers.Family_Relationships.sents.batch0040
prefix=/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval_v2/answers.Family_Relationships.sents.batch0040
informal_file=$prefix.org.tok.informal

declare -a files=(
		"$prefix.tok.informal"
		"$prefix.filtered.tok.formal.ref0_1_2_3"
		"$prefix.filtered.selftraining10x.gt0editdit.lm_All_gt_0.smt.formal"
		"$prefix.tok.nmt.50K.ansemb.formal"
		"$prefix.tok.nmt.50K.ansemb.copy.formal"
		"$prefix.tok.nmt.50K.ansemb.copy.selftraining10x.gt10editdist.nmtbacktranslate.formal"
		);
suffix=part1
for file in "${files[@]}"; do
	#ls $file.$suffix
	th predictwithSTS.lua -informal_file $informal_file.$suffix -formal_file $file.$suffix
	#echo $file
	#python /projects/style_transfer/scripts/calculate_avg_formality.py $file.meaning.predictions	
	#python /projects/style_transfer/scripts/calculate_avg_formality.py $file.formality.predictions	
done

