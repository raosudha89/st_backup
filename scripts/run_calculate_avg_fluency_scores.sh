old_prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test/final_human_eval/answers.Entertainment_Music.sents.batch040
prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test/final_human_eval_v2/answers.Entertainment_Music.sents.batch040
old_prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval/answers.Family_Relationships.sents.batch0040
prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval_v2/answers.Family_Relationships.sents.batch0040
declare -a files_EM=(
	"org.tok.informal"
	"tok.formal.filtered.ref0_1_2_3"
	"tok.informal"
	"filtered.selftraining6x.gt10editdist.lm_All_gt_0.smt.formal"
	"tok.nmt.50K.ansemb.formal"
	"tok.nmt.50K.ansemb.copy.formal"
	"tok.nmt.50K.ansemb.copy.selftraining6x.gt10editdist.nmtbacktranslate.formal"
	);
declare -a files_FR=(
	"org.tok.informal"
	"filtered.tok.formal.ref0_1_2_3"
	"tok.informal"
	"filtered.selftraining10x.gt0editdit.lm_All_gt_0.smt.formal"
	"tok.nmt.50K.ansemb.formal"
	"tok.nmt.50K.ansemb.copy.formal"
	"tok.nmt.50K.ansemb.copy.selftraining10x.gt10editdist.nmtbacktranslate.formal"
	);

suffix=part1.fluency.predictions
src_prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test/answers.Entertainment_Music.sents.batch040
src_prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test/answers.Family_Relationships.sents.batch0040
src_suffix=fluency.predictions
for file in "${files_EM[@]}"; do
	#ls $src_prefix_EM.$file.$src_suffix
	#sed -n '1,500p' $src_prefix_EM.$file.$src_suffix > $prefix_EM.$file.$suffix
	#cp $old_prefix_EM.$file.$suffix $prefix_EM.$file.$suffix
	ls $prefix_EM.$file.$suffix
	python /projects/style_transfer/scripts/calculate_avg_formality.py $prefix_EM.$file.$suffix	
done
for file in "${files_FR[@]}"; do
	#ls $src_prefix_FR.$file.$src_suffix
	#sed -n '1,500p' $src_prefix_FR.$file.$src_suffix > $prefix_FR.$file.$suffix
	#cp $old_prefix_FR.$file.$suffix $prefix_FR.$file.$suffix
	ls $prefix_FR.$file.$suffix	
	python /projects/style_transfer/scripts/calculate_avg_formality.py $prefix_FR.$file.$suffix	
done

