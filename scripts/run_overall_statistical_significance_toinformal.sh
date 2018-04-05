prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test2/final_human_eval/answers.Entertainment_Music.sents.batch040.tok
prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test2/final_human_eval/answers.Family_Relationships.sents.batch0040.tok

declare -a files_EM=(
#	"formal"
#	"informal.ref0_1_2_3"
#	"rulebased.informal"
	"smt.onrulebased.selftraining5x.gt10editdist.informal"
	"nmt.50K.ansemb.informal"
	"nmt.50K.ansemb.copy.informal"
	"nmt.50K.ansemb.copy.onrulebased.selftraining5x.gt10editdist.nmtbacktranslate.informal"
	);
declare -a files_FR=(
#	"formal"
#	"informal.ref0_1_2_3"
#	"rulebased.informal"
	"smt.onrulebased.selftraining10x.gt10editdist.informal"
	"nmt.50K.ansemb.informal"
	"nmt.50K.ansemb.copy.informal"
	"nmt.50K.ansemb.copy.onrulebased.selftraining10x.gt10editdist.nmtbacktranslate.informal"
	);

declare -a files_sys=(
#	"ref"
#	"rule_based"
	"smt_combined"
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
metric=sent_bleu_scores
#metric=sent_terp_scores
#metric=sent_pinc_scores

src_model=rulebased.informal

#metric=sys_ranking
#src_model=rule_based

echo 'EM'
for file in "${files_EM[@]}"; do
#for sys in "${files_sys[@]}"; do
	echo $file
	python $script $prefix_EM.$file.part1.$metric $prefix_EM.$src_model.part1.$metric  
	#echo $sys
	#python $script $prefix_EM.part1.$metric.$sys $prefix_EM.part1.$metric.$src_model
done
echo 'FR'
for file in "${files_FR[@]}"; do
#for sys in "${files_sys[@]}"; do
	echo $file
        python $script $prefix_FR.$file.part1.$metric $prefix_FR.$src_model.part1.$metric
        #echo $sys
	#python $script $prefix_FR.part1.$metric.$sys $prefix_FR.part1.$metric.$src_model
done
