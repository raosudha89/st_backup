full_prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test2/answers.Entertainment_Music.sents.batch040.tok
full_prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test2/answers.Family_Relationships.sents.batch0040.tok
prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test2/final_human_eval/answers.Entertainment_Music.sents.batch040.tok
prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test2/final_human_eval/answers.Family_Relationships.sents.batch0040.tok

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

ref_prefix_EM=$prefix_EM.informal.ref
ref_prefix_FR=$prefix_FR.informal.ref

cd /projects/style_transfer/terp

for file in "${files_EM[@]}"; do
	/projects/style_transfer/mosesdecoder/bin/sentence-bleu ${ref_prefix_EM}0.part1 ${ref_prefix_EM}1.part1 ${ref_prefix_EM}2.part1 ${ref_prefix_EM}3.part1 < $prefix_EM.$file.part1 > $prefix_EM.$file.part1.sent_bleu_scores
done

for file in "${files_FR[@]}"; do
	/projects/style_transfer/mosesdecoder/bin/sentence-bleu ${ref_prefix_FR}0.part1 ${ref_prefix_FR}1.part1 ${ref_prefix_FR}2.part1 ${ref_prefix_FR}3.part1 < $prefix_FR.$file.part1 > $prefix_FR.$file.part1.sent_bleu_scores
done
