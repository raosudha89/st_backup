full_prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test2/answers.Entertainment_Music.sents.batch040.tok
full_prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test2/answers.Family_Relationships.sents.batch0040.tok
prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test2/final_human_eval/answers.Entertainment_Music.sents.batch040.tok
prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test2/final_human_eval/answers.Family_Relationships.sents.batch0040.tok

for i in {0..3}; do
	sed -n '1,500p' $full_prefix_EM.informal.ref$i > $prefix_EM.informal.ref$i.part1
	sed -n '1,500p' $full_prefix_FR.informal.ref$i > $prefix_FR.informal.ref$i.part1
done

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
