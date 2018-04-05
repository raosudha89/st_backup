prefix=/corpora/yahoo_answers/final_data/Entertainment_Music/test2/answers.Entertainment_Music.sents.batch040.tok

declare -a files=(
	"$prefix.formal"
	"$prefix.informal.ref0"
	"$prefix.informal.ref1"
	"$prefix.informal.ref2"
	"$prefix.informal.ref3"
	"$prefix.rulebased.informal"
	"$prefix.smt.informal"
	"$prefix.smt.onrulebased.informal"
	"$prefix.smt.onrulebased.selftraining10x.informal"
	"$prefix.smt.onrulebased.selftraining.gt16editdist.informal"
	"$prefix.smt.onrulebased.selftraining5x.gt10editdist.informal"
	"$prefix.nmt.50K.informal"
	"$prefix.nmt.50K.ansemb.informal"
	"$prefix.nmt.50K.ansemb.copy.informal"
	"$prefix.nmt.50K.ansemb.onrulebased.selftraining10x.informal"
	"$prefix.nmt.50K.ansemb.copy.onrulebased.selftraining10x.informal"
	"$prefix.nmt.50K.ansemb.copy.onrulebased.selftraining.gt16editdist.informal"
	"$prefix.nmt.50K.ansemb.copy.onrulebased.selftraining5x.gt10editdist.informal"
	"$prefix.nmt.50K.ansemb.copy.onrulebased.selftraining5x.gt10editdist.nmtbacktranslate.informal"
	);

for file in "${files[@]}"; do
	cp $file /projects/style_transfer/for_fluency/EM/to_informal/
done

