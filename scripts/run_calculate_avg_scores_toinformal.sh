full_prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test2/answers.Entertainment_Music.sents.batch040.tok
full_prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test2/answers.Family_Relationships.sents.batch0040.tok
prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test2/final_human_eval/answers.Entertainment_Music.sents.batch040.tok
prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test2/final_human_eval/answers.Family_Relationships.sents.batch0040.tok

#for i in {0..3}; do
#	sed -n '1,500p' $full_prefix_EM.informal.ref$i.json.ord > $prefix_EM.informal.ref$i.part1.fluency.predictions
#	sed -n '1,500p' $full_prefix_FR.informal.ref$i.json.ord > $prefix_FR.informal.ref$i.part1.fluency.predictions
#done

python /projects/style_transfer/scripts/get_fluency_by_refno.py $prefix_EM.informal.ref0_1_2_3.withindices.part1 $prefix_EM.informal.ref0.part1.fluency.predictions $prefix_EM.informal.ref1.part1.fluency.predictions $prefix_EM.informal.ref2.part1.fluency.predictions $prefix_EM.informal.ref3.part1.fluency.predictions $prefix_EM.informal.ref0_1_2_3.part1.fluency.predictions 

python /projects/style_transfer/scripts/get_fluency_by_refno.py $prefix_FR.informal.ref0_1_2_3.withindices.part1 $prefix_FR.informal.ref0.part1.fluency.predictions $prefix_FR.informal.ref1.part1.fluency.predictions $prefix_FR.informal.ref2.part1.fluency.predictions $prefix_FR.informal.ref3.part1.fluency.predictions $prefix_FR.informal.ref0_1_2_3.part1.fluency.predictions

declare -a files_EM=(
	"formal"
	"informal.ref0_1_2_3"
	"rulebased.informal"
	"smt.onrulebased.selftraining5x.gt10editdist.informal"
	"nmt.50K.ansemb.informal"
	"nmt.50K.ansemb.copy.informal"
	"nmt.50K.ansemb.copy.onrulebased.selftraining5x.gt10editdist.nmtbacktranslate.informal"
	);
declare -a files_FR=(
	"formal"
	"informal.ref0_1_2_3"
	"rulebased.informal"
	"smt.onrulebased.selftraining10x.gt10editdist.informal"
	"nmt.50K.ansemb.informal"
	"nmt.50K.ansemb.copy.informal"
	"nmt.50K.ansemb.copy.onrulebased.selftraining10x.gt10editdist.nmtbacktranslate.informal"
	);

#for file in "${files_EM[@]}"; do
	#sed -n '1,500p' $full_prefix_EM.$file.formality.predictions > $prefix_EM.$file.part1.formality.predictions
#	ls $prefix_EM.$file.part1
	#python /projects/style_transfer/scripts/calculate_avg_formality.py $prefix_EM.$file.part1.formality.human
	#python /projects/style_transfer/scripts/calculate_avg_formality.py $prefix_EM.$file.part1.formality.predictions	
	#python /projects/style_transfer/scripts/calculate_avg_formality.py $prefix_EM.$file.part1.fluency.human
	#python /projects/style_transfer/scripts/calculate_avg_formality.py $prefix_EM.$file.part1.meaning.human
	#sed -n '1,500p' $full_prefix_EM.$file.meaning.predictions.sts > $prefix_EM.$file.part1.meaning.predictions.sts
	#python /projects/style_transfer/scripts/calculate_avg_formality.py $prefix_EM.$file.part1.meaning.predictions.sts
	#sed -n '1,500p' $full_prefix_EM.$file.json.ord > $prefix_EM.$file.part1.fluency.predictions
#	python /projects/style_transfer/scripts/calculate_avg_formality.py $prefix_EM.$file.part1.fluency.predictions
#done

for file in "${files_FR[@]}"; do
	#sed -n '1,500p' $full_prefix_FR.$file.formality.predictions > $prefix_FR.$file.part1.formality.predictions
	ls $prefix_FR.$file.part1	
	#python /projects/style_transfer/scripts/calculate_avg_formality.py $prefix_FR.$file.part1.formality.human
	#python /projects/style_transfer/scripts/calculate_avg_formality.py $prefix_FR.$file.part1.formality.predictions
	#python /projects/style_transfer/scripts/calculate_avg_formality.py $prefix_FR.$file.part1.fluency.human
	#python /projects/style_transfer/scripts/calculate_avg_formality.py $prefix_FR.$file.part1.meaning.human
	#sed -n '1,500p' $full_prefix_FR.$file.meaning.predictions.sts > $prefix_FR.$file.part1.meaning.predictions.sts
	#python /projects/style_transfer/scripts/calculate_avg_formality.py $prefix_FR.$file.part1.meaning.predictions.sts
	#sed -n '1,500p' $full_prefix_FR.$file.json.ord > $prefix_FR.$file.part1.fluency.predictions
	python /projects/style_transfer/scripts/calculate_avg_formality.py $prefix_FR.$file.part1.fluency.predictions
done
