prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test/final_human_eval_v2/answers.Entertainment_Music.sents.batch040
prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval_v2/answers.Family_Relationships.sents.batch0040

declare -a files_EM=(
	"tok.formal.filtered.ref0_1_2_3"
	"tok.informal"
	"filtered.selftraining6x.gt10editdist.lm_All_gt_0.smt.formal"
	"tok.nmt.50K.ansemb.formal"
	"tok.nmt.50K.ansemb.copy.formal"
	"tok.nmt.50K.ansemb.copy.selftraining6x.gt10editdist.nmtbacktranslate.formal"
	);
declare -a files_FR=(
	"filtered.tok.formal.ref0_1_2_3"
	"tok.informal"
	"filtered.selftraining10x.gt0editdit.lm_All_gt_0.smt.formal"
	"tok.nmt.50K.ansemb.formal"
	"tok.nmt.50K.ansemb.copy.formal"
	"tok.nmt.50K.ansemb.copy.selftraining10x.gt10editdist.nmtbacktranslate.formal"
	);

src_prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test/final_human_eval_v2/answers.Entertainment_Music.sents.batch040.org.tok.informal
src_prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval_v2/answers.Family_Relationships.sents.batch0040.org.tok.informal

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
