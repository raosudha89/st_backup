full_prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test2/answers.Entertainment_Music.sents.batch040.tok
full_prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test2/answers.Family_Relationships.sents.batch0040.tok
prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test2/final_human_eval/answers.Entertainment_Music.sents.batch040.tok
prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test2/final_human_eval/answers.Family_Relationships.sents.batch0040.tok

declare -a files_EM=(
	"informal.ref0_1_2_3"
	"rulebased.informal"
	"smt.onrulebased.selftraining5x.gt10editdist.informal"
	"nmt.50K.ansemb.informal"
	"nmt.50K.ansemb.copy.informal"
	"nmt.50K.ansemb.copy.onrulebased.selftraining5x.gt10editdist.nmtbacktranslate.informal"
	);
declare -a files_FR=(
	"informal.ref0_1_2_3"
	"rulebased.informal"
	"smt.onrulebased.selftraining10x.gt10editdist.informal"
	"nmt.50K.ansemb.informal"
	"nmt.50K.ansemb.copy.informal"
	"nmt.50K.ansemb.copy.onrulebased.selftraining10x.gt10editdist.nmtbacktranslate.informal"
	);

src_prefix_EM=$prefix_EM.formal
src_prefix_FR=$prefix_FR.formal

for file in "${files_EM[@]}"; do
	rm $prefix_EM.$file.part1.sent_pinc_scores
	echo $prefix_EM.$file.part1 
	for num in {1..500}; do
		sed "${num}q;d" $prefix_EM.$file.part1 > model
		sed "${num}q;d" $src_prefix_EM.part1 > src
		perl /projects/style_transfer/Shakespearizing-Modern-English/code/main/PINC.perl src < model >> $prefix_EM.$file.part1.sent_pinc_scores
	done
done

for file in "${files_FR[@]}"; do
	rm $prefix_FR.$file.part1.sent_pinc_scores
	echo $prefix_FR.$file.part1 
	for num in {1..500}; do
		sed "${num}q;d" $prefix_FR.$file.part1 > model
		sed "${num}q;d" $src_prefix_FR.part1 > src
		perl /projects/style_transfer/Shakespearizing-Modern-English/code/main/PINC.perl src < model >> $prefix_FR.$file.part1.sent_pinc_scores
	done
done
