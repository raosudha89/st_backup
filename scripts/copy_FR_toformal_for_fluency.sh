prefix=/corpora/yahoo_answers/final_data/Family_Relationships/test/answers.Family_Relationships.sents.batch0040

declare -a files=(
		"$prefix.tok.formal.ref0" 
		"$prefix.tok.formal.ref1" 
		"$prefix.tok.formal.ref2" 
		"$prefix.tok.formal.ref3"
		"$prefix.tok.nmt.50K.formal"
		"$prefix.tok.nmt.50K.ansemb.formal"
		"$prefix.tok.nmt.50K.ansemb.copy.formal"
		"$prefix.tok.nmt.50K.ansemb.selftraining10x.formal"
		"$prefix.tok.nmt.50K.ansemb.copy.selftraining10x.formal"
		"$prefix.tok.nmt.50K.ansemb.copy.selftraining10x.nmtbacktranslate.formal"
		"$prefix.tok.nmt.50K.ansemb.copy.selftraining.gt20editdist.formal"
		"$prefix.tok.nmt.50K.ansemb.selftraining.gt20editdist.formal"
		"$prefix.tok.nmt.50K.ansemb.copy.selftraining10x.gt10editdist.formal"
		"$prefix.tok.nmt.50K.ansemb.copy.selftraining10x.gt10editdist.nmtbacktranslate.formal"
		);

for file in "${files[@]}"; do
	cp $file /projects/style_transfer/for_fluency/FR/to_formal
done

