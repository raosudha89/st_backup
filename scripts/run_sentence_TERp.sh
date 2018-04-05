prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test/final_human_eval_v2/answers.Entertainment_Music.sents.batch040
prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval_v2/answers.Family_Relationships.sents.batch0040

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

ref_prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test/final_human_eval_v2/answers.Entertainment_Music.sents.batch040.tok.formal.filtered.ref
ref_prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval_v2/answers.Family_Relationships.sents.batch0040.filtered.tok.formal.ref

cd /projects/style_transfer/terp

for file in "${files_EM[@]}"; do
	rm $prefix_EM.$file.part1.sent_terp_scores
	echo $prefix_EM.$file.part1 
	for num in {1..500}; do
		sed "${num}q;d" $prefix_EM.$file.part1 > model
		sed "${num}q;d" ${ref_prefix_EM}0.part1 > ref0
		sed "${num}q;d" ${ref_prefix_EM}1.part1 > ref1
		sed "${num}q;d" ${ref_prefix_EM}2.part1 > ref2
		sed "${num}q;d" ${ref_prefix_EM}3.part1 > ref3
		python to_terp_format.py model
		python to_terp_format.py ref0
		python to_terp_format.py ref1
		python to_terp_format.py ref2
		python to_terp_format.py ref3
		bin/terp -r ref0.terpformat -r ref1.terpformat -r ref2.terpformat -r ref3.terpformat -h model.terpformat > terp_score
		tail -1 terp_score >> $prefix_EM.$file.part1.sent_terp_scores	
	done
done

for file in "${files_FR[@]}"; do
	rm $prefix_FR.$file.part1.sent_terp_scores
	echo $prefix_FR.$file.part1 
	for num in {1..500}; do
		sed "${num}q;d" $prefix_FR.$file.part1 > model
		sed "${num}q;d" ${ref_prefix_FR}0.part1 > ref0
		sed "${num}q;d" ${ref_prefix_FR}1.part1 > ref1
		sed "${num}q;d" ${ref_prefix_FR}2.part1 > ref2
		sed "${num}q;d" ${ref_prefix_FR}3.part1 > ref3
		python to_terp_format.py model
		python to_terp_format.py ref0
		python to_terp_format.py ref1
		python to_terp_format.py ref2
		python to_terp_format.py ref3
		bin/terp -r ref0.terpformat -r ref1.terpformat -r ref2.terpformat -r ref3.terpformat -h model.terpformat > terp_score
		tail -1 terp_score >> $prefix_FR.$file.part1.sent_terp_scores	
	done
done
