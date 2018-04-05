prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test/final_human_eval_v2/answers.Entertainment_Music.sents.batch040
prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval_v2/answers.Family_Relationships.sents.batch0040

declare -a files_EM=(
#	"tok.informal"
#	"tok.formal.filtered.ref0_1_2_3"
	"filtered.selftraining6x.gt10editdist.lm_All_gt_0.smt.formal"
	"tok.nmt.50K.ansemb.formal"
	"tok.nmt.50K.ansemb.copy.formal"
	"tok.nmt.50K.ansemb.copy.selftraining6x.gt10editdist.nmtbacktranslate.formal"
	);
declare -a files_FR=(
#	"tok.informal"
#	"filtered.tok.formal.ref0_1_2_3"
	"filtered.selftraining10x.gt0editdit.lm_All_gt_0.smt.formal"
	"tok.nmt.50K.ansemb.formal"
	"tok.nmt.50K.ansemb.copy.formal"
	"tok.nmt.50K.ansemb.copy.selftraining10x.gt10editdist.nmtbacktranslate.formal"
	);

declare -a files_sys=(
#	"rule_based"
#	"ref"
	"smt_ensemble"
	"nmt_baseline"
	"nmt_copy"
	"nmt_combined"
	)

script=/projects/style_transfer/scripts/calculate_statistical_significance.py
#metric=formality.human
#metric=formality.predictions
#metric=fluency.human
#metric=fluency.predictions
#metric=meaning.human
#metric=meaning.predictions.sts
#metric=combined.human
#metric=combined.predictions
#metric=sent_bleu_scores
#metric=sent_terp_scores
metric=sent_pinc_scores

#src_model=tok.informal

metric=sys_ranking
src_model=rule_based

#echo 'EM'
#for file in "${files_EM[@]}"; do
#for sys in "${files_sys[@]}"; do
#	echo $sys
#	#python $script $prefix_EM.$file.part1.$metric $prefix_EM.$src_model.part1.$metric  
#	python $script $prefix_EM.part1.$metric.$sys $prefix_EM.part1.$metric.$src_model
#done
echo 'FR'
#for file in "${files_FR[@]}"; do
for file in "${files_sys[@]}"; do
	echo $file
        #python $script $prefix_FR.$file.part1.$metric $prefix_FR.$src_model.part1.$metric
        python $script $prefix_FR.part1.$metric.$file $prefix_FR.part1.$metric.$src_model
done
