prefix=/corpora/yahoo_answers/final_data/Entertainment_Music/test/answers.Entertainment_Music.sents.batch040
prefix=/corpora/yahoo_answers/final_data/Entertainment_Music/test/final_human_eval_v2/answers.Entertainment_Music.sents.batch040
informal_file="$prefix.org.tok.informal"

declare -a files=(
#	"$prefix.tok.informal"
	"$prefix.tok.formal.filtered.ref0_1_2_3" 
#	"$prefix.filtered.selftraining6x.gt10editdist.lm_All_gt_0.smt.formal" 
#	"$prefix.tok.formal.filtered.ref0" 
#	"$prefix.tok.formal.filtered.ref1" 
#	"$prefix.tok.formal.filtered.ref2" 
#	"$prefix.tok.formal.filtered.ref3"
#	"$prefix.tok.nmt.50K.ansemb.formal"
#	"$prefix.tok.nmt.50K.ansemb.copy.formal"
#	"$prefix.tok.nmt.50K.ansemb.copy.selftraining6x.gt10editdist.nmtbacktranslate.formal"
	);
suffix=part1
for file in "${files[@]}"; do
	th predictwithSTS.lua -informal_file $informal_file.$suffix -formal_file $file.$suffix
	#python /projects/style_transfer/scripts/calculate_avg_formality.py $file.meaning.predictions.sts
done

