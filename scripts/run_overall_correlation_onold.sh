prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test/final_human_eval/answers.Entertainment_Music.sents.batch040
prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval/answers.Family_Relationships.sents.batch0040

declare -a files_EM=(
#	"org.tok.informal"
	"tok.formal.filtered.ref0_1_2_3"
	"tok.informal"
	"filtered.selftraining6x.gt10editdist.lm_All_gt_0.smt.formal"
	"model.50K_epoch14_29.77.formal"
	"selftraining10x.usingnmtbacktranslate.nmtbpe.usinglm_epoch8_25.80.formal"
	);
declare -a files_FR=(
#	"org.tok.informal"
	"filtered.tok.formal.ref0_1_2_3"
	"tok.informal"
	"filtered.selftraining10x.gt0editdit.lm_All_gt_0.smt.formal"
	"filtered.model.50K_epoch13_13.89.formal"
	"filtered.smt.Family_Relationships.model.selftraining10x.usingnmtbacktranslate.nmtbpe.usinglm_epoch5_15.21.formal"
	);

metric_a=sent_bleu_scores
#metric_a=formality.predictions
#metric_a=fluency.predictions
#metric_a=meaning.predictions.sts
#metric_a=combined.predictions

metric_b=sys_ranking
#metric_b=formality.human
#metric_b=fluency.human
#metric_b=meaning.human
#metric_b=combined.human

for file in "${files_EM[@]}"; do
	cat $prefix_EM.$file.part1.$metric_a >> $prefix_EM.part1.$metric_a.temp
done

for file in "${files_EM[@]}"; do
	cat $prefix_EM.$file.part1.$metric_b >> $prefix_EM.part1.$metric_b.temp
done

python /projects/style_transfer/scripts/calculate_spearmanr.py $prefix_EM.part1.$metric_a.temp $prefix_EM.part1.$metric_b.temp
rm $prefix_EM.part1.$metric_a.temp
rm $prefix_EM.part1.$metric_b.temp

for file in "${files_FR[@]}"; do
	cat $prefix_FR.$file.part1.$metric_a >> $prefix_FR.part1.$metric_a.temp
done

for file in "${files_FR[@]}"; do
	cat $prefix_FR.$file.part1.$metric_b >> $prefix_FR.part1.$metric_b.temp
done

python /projects/style_transfer/scripts/calculate_spearmanr.py $prefix_FR.part1.$metric_a.temp $prefix_FR.part1.$metric_b.temp
rm $prefix_FR.part1.$metric_a.temp
rm $prefix_FR.part1.$metric_b.temp
