prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test/final_human_eval_v2/answers.Entertainment_Music.sents.batch040
prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval_v2/answers.Family_Relationships.sents.batch0040
src_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test/final_human_eval_v2/answers.Entertainment_Music.sents.batch040.org.tok.informal
src_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval_v2/answers.Family_Relationships.sents.batch0040.org.tok.informal
declare -a files_EM=(
	"org.tok.informal"
	"tok.formal.filtered.ref0_1_2_3"
	"tok.informal"
	"filtered.selftraining6x.gt10editdist.lm_All_gt_0.smt.formal"
	"tok.nmt.50K.ansemb.formal"
	"tok.nmt.50K.ansemb.copy.formal"
	"tok.nmt.50K.ansemb.copy.selftraining6x.gt10editdist.nmtbacktranslate.formal"
	);
declare -a files_FR=(
	"org.tok.informal"
	"filtered.tok.formal.ref0_1_2_3"
	"tok.informal"
	"filtered.selftraining10x.gt0editdit.lm_All_gt_0.smt.formal"
	"tok.nmt.50K.ansemb.formal"
	"tok.nmt.50K.ansemb.copy.formal"
	"tok.nmt.50K.ansemb.copy.selftraining10x.gt10editdist.nmtbacktranslate.formal"
	);

#for file in "${files_EM[@]}"; do
#	ls $prefix_EM.$file.part1
#	perl /projects/style_transfer/Shakespearizing-Modern-English/code/main/PINC.perl $src_EM.part1 < $prefix_EM.$file.part1
#done

for file in "${files_FR[@]}"; do
	ls $prefix_FR.$file.part1
	perl /projects/style_transfer/Shakespearizing-Modern-English/code/main/PINC.perl $src_FR.part1 < $prefix_FR.$file.part1
done
