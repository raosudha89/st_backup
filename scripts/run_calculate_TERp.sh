prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test/final_human_eval_v2/answers.Entertainment_Music.sents.batch040
prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval_v2/answers.Family_Relationships.sents.batch0040
ref_prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test/final_human_eval_v2/answers.Entertainment_Music.sents.batch040.tok.formal.filtered.ref
ref_prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval_v2/answers.Family_Relationships.sents.batch0040.filtered.tok.formal.ref
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
cd /projects/style_transfer/terp

python to_terp_format.py ${ref_prefix_EM}0.part1 
python to_terp_format.py ${ref_prefix_EM}1.part1 
python to_terp_format.py ${ref_prefix_EM}2.part1 
python to_terp_format.py ${ref_prefix_EM}3.part1

python to_terp_format.py ${ref_prefix_FR}0.part1 
python to_terp_format.py ${ref_prefix_FR}1.part1 
python to_terp_format.py ${ref_prefix_FR}2.part1 
python to_terp_format.py ${ref_prefix_FR}3.part1

for file in "${files_EM[@]}"; do
	ls $prefix_EM.$file.part1
	python to_terp_format.py $prefix_EM.$file.part1
	bin/terp -r ${ref_prefix_EM}0.part1.terpformat -r ${ref_prefix_EM}1.part1.terpformat -r ${ref_prefix_EM}2.part1.terpformat -r ${ref_prefix_EM}3.part1.terpformat -h $prefix_EM.$file.part1.terpformat > temp
	tail -1 temp	
done

for file in "${files_FR[@]}"; do
	ls $prefix_FR.$file.part1
	python to_terp_format.py $prefix_FR.$file.part1
	bin/terp -r ${ref_prefix_FR}0.part1.terpformat -r ${ref_prefix_FR}1.part1.terpformat -r ${ref_prefix_FR}2.part1.terpformat -r ${ref_prefix_FR}3.part1.terpformat -h $prefix_FR.$file.part1.terpformat > temp
	tail -1 temp	
done
