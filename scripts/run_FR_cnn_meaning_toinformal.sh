prefix=/corpora/yahoo_answers/final_data/Family_Relationships/test2/answers.Family_Relationships.sents.batch0040.tok
formal_file=$prefix.formal

declare -a files=(
		"$prefix.informal.ref0"
		"$prefix.informal.ref1"
		"$prefix.informal.ref2"
		"$prefix.informal.ref3"

		"$prefix.rulebased.informal"
#		"$prefix.smt.informal"
#		"$prefix.smt.onrulebased.informal"
#		"$prefix.smt.onrulebased.selftraining10x.informal"
#		"$prefix.smt.onrulebased.selftraining.gt21editdist.informal"
		"$prefix.smt.onrulebased.selftraining10x.gt10editdist.informal"

#		"$prefix.nmt.50K.informal"
		"$prefix.nmt.50K.ansemb.informal"
		"$prefix.nmt.50K.ansemb.copy.informal"
#		"$prefix.nmt.50K.ansemb.onrulebased.selftraining10x.informal"
#		"$prefix.nmt.50K.ansemb.copy.onrulebased.selftraining10x.informal"
#		"$prefix.nmt.50K.ansemb.copy.onrulebased.selftraining.gt21editdist.informal"
#		"$prefix.nmt.50K.ansemb.copy.onrulebased.selftraining10x.gt10editdist.informal"
		"$prefix.nmt.50K.ansemb.copy.onrulebased.selftraining10x.gt10editdist.nmtbacktranslate.informal"
		);

for file in "${files[@]}"; do
	#ls $file
	th predictwithSTS_toinformal.lua -informal_file $file -formal_file $formal_file
	#echo $file
	#python /projects/style_transfer/scripts/calculate_avg_formality.py $file.meaning.predictions	
	#python /projects/style_transfer/scripts/calculate_avg_formality.py $file.formality.predictions	
done

