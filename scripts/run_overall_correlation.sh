prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test/final_human_eval_v2/answers.Entertainment_Music.sents.batch040
prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval_v2/answers.Family_Relationships.sents.batch0040

declare -a files_EM=(
#	"org.tok.informal"
	"tok.formal.filtered.ref0_1_2_3"
	"tok.informal"
	"filtered.selftraining6x.gt10editdist.lm_All_gt_0.smt.formal"
	"tok.nmt.50K.ansemb.formal"
	"tok.nmt.50K.ansemb.copy.formal"
	"tok.nmt.50K.ansemb.copy.selftraining6x.gt10editdist.nmtbacktranslate.formal"
	);
declare -a files_FR=(
#	"org.tok.informal"
	"filtered.tok.formal.ref0_1_2_3"
	"tok.informal"
	"filtered.selftraining10x.gt0editdit.lm_All_gt_0.smt.formal"
	"tok.nmt.50K.ansemb.formal"
	"tok.nmt.50K.ansemb.copy.formal"
	"tok.nmt.50K.ansemb.copy.selftraining10x.gt10editdist.nmtbacktranslate.formal"
	);

declare -a files_sys=(
	"ref"
	"rule_based"
	"smt_ensemble"
	"nmt_baseline"
	"nmt_copy"
	"nmt_combined"
	)

#metric_a=sent_bleu_scores
#metric_a=sent_terp_scores
#metric_a=sent_pinc_scores
#metric_a=formality.predictions
#metric_a=fluency.predictions
#metric_a=meaning.predictions.sts
metric_a=combined.predictions

#metric_b=sys_ranking
#metric_b=sys_ranking.v2
#metric_b=formality.human
#metric_b=fluency.human
#metric_b=meaning.human
metric_b=combined.human

for file in "${files_EM[@]}"; do
	cat $prefix_EM.$file.part1.$metric_a >> $prefix_EM.part1.$metric_a.temp
done

if [ "$metric_b" == "sys_ranking" ] || [ "$metric_b" == "sys_ranking.v2" ] 
then
	for sys in "${files_sys[@]}"; do
		cat $prefix_EM.part1.$metric_b.$sys >> $prefix_EM.part1.$metric_b.temp
	done
else
	for file in "${files_EM[@]}"; do
		cat $prefix_EM.$file.part1.$metric_b >> $prefix_EM.part1.$metric_b.temp
	done
fi
wc -l $prefix_EM.part1.$metric_a.temp
wc -l $prefix_EM.part1.$metric_b.temp
python /projects/style_transfer/scripts/calculate_spearmanr.py $prefix_EM.part1.$metric_a.temp $prefix_EM.part1.$metric_b.temp
rm $prefix_EM.part1.$metric_a.temp
rm $prefix_EM.part1.$metric_b.temp

for file in "${files_FR[@]}"; do
	cat $prefix_FR.$file.part1.$metric_a >> $prefix_FR.part1.$metric_a.temp
done

if [ "$metric_b" == "sys_ranking" ] || [ "$metric_b" == "sys_ranking.v2" ] 
then
	for sys in "${files_sys[@]}"; do
		cat $prefix_FR.part1.$metric_b.$sys >> $prefix_FR.part1.$metric_b.temp
	done
else
	for file in "${files_FR[@]}"; do
		cat $prefix_FR.$file.part1.$metric_b >> $prefix_FR.part1.$metric_b.temp
	done
fi

wc -l $prefix_FR.part1.$metric_a.temp
wc -l $prefix_FR.part1.$metric_b.temp
python /projects/style_transfer/scripts/calculate_spearmanr.py $prefix_FR.part1.$metric_a.temp $prefix_FR.part1.$metric_b.temp
rm $prefix_FR.part1.$metric_a.temp
rm $prefix_FR.part1.$metric_b.temp
