prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test2/final_human_eval/answers.Entertainment_Music.sents.batch040.tok
prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test2/final_human_eval/answers.Family_Relationships.sents.batch0040.tok

declare -a files_EM=(
#	"formal"
	"informal.ref0_1_2_3"
	"rulebased.informal"
	"smt.onrulebased.selftraining5x.gt10editdist.informal"
	"nmt.50K.ansemb.informal"
	"nmt.50K.ansemb.copy.informal"
	"nmt.50K.ansemb.copy.onrulebased.selftraining5x.gt10editdist.nmtbacktranslate.informal"
	);
declare -a files_FR=(
#	"formal"
	"informal.ref0_1_2_3"
	"rulebased.informal"
	"smt.onrulebased.selftraining10x.gt10editdist.informal"
	"nmt.50K.ansemb.informal"
	"nmt.50K.ansemb.copy.informal"
	"nmt.50K.ansemb.copy.onrulebased.selftraining10x.gt10editdist.nmtbacktranslate.informal"
	);

declare -a files_sys=(
	"ref"
	"rule_based"
	"smt_combined"
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

metric_b=sys_ranking
#metric_b=sys_ranking.v2
#metric_b=formality.human
#metric_b=fluency.human
#metric_b=meaning.human
#metric_b=combined.human

rm $prefix_EM.part1.$metric_a.temp
rm $prefix_EM.part1.$metric_b.temp
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

rm $prefix_FR.part1.$metric_a.temp
rm $prefix_FR.part1.$metric_b.temp
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
