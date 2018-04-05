full_prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test2/answers.Entertainment_Music.sents.batch040.tok
full_prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test2/answers.Family_Relationships.sents.batch0040.tok
prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test2/final_human_eval/answers.Entertainment_Music.sents.batch040.tok
prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test2/final_human_eval/answers.Family_Relationships.sents.batch0040.tok
src_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test2/final_human_eval/answers.Entertainment_Music.sents.batch040.tok.formal
src_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test2/final_human_eval/answers.Family_Relationships.sents.batch0040.tok.formal

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

for file in "${files_EM[@]}"; do
	#sed -n '1,500p' $full_prefix_EM.$file > $prefix_EM.$file.part1
	ls $prefix_EM.$file.part1
	perl /projects/style_transfer/Shakespearizing-Modern-English/code/main/PINC.perl $src_EM.part1 < $prefix_EM.$file.part1
done

for file in "${files_FR[@]}"; do
	#sed -n '1,500p' $full_prefix_FR.$file > $prefix_FR.$file.part1
	ls $prefix_FR.$file.part1
	perl /projects/style_transfer/Shakespearizing-Modern-English/code/main/PINC.perl $src_FR.part1 < $prefix_FR.$file.part1
done
