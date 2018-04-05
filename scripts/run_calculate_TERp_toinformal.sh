full_prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test2/answers.Entertainment_Music.sents.batch040.tok
full_prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test2/answers.Family_Relationships.sents.batch0040.tok
prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test2/final_human_eval/answers.Entertainment_Music.sents.batch040.tok
prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test2/final_human_eval/answers.Family_Relationships.sents.batch0040.tok
ref_prefix_EM=/corpora/yahoo_answers/final_data/Entertainment_Music/test2/final_human_eval/answers.Entertainment_Music.sents.batch040.tok.informal.part1.ref
ref_prefix_FR=/corpora/yahoo_answers/final_data/Family_Relationships/test2/final_human_eval/answers.Family_Relationships.sents.batch0040.tok.informal.part1.ref

#sed -n '1,500p' $full_prefix_EM.informal.ref0 > ${ref_prefix_EM}0
#sed -n '1,500p' $full_prefix_EM.informal.ref1 > ${ref_prefix_EM}1
#sed -n '1,500p' $full_prefix_EM.informal.ref2 > ${ref_prefix_EM}2
#sed -n '1,500p' $full_prefix_EM.informal.ref3 > ${ref_prefix_EM}3

#sed -n '1,500p' $full_prefix_FR.informal.ref0 > ${ref_prefix_FR}0 
#sed -n '1,500p' $full_prefix_FR.informal.ref1 > ${ref_prefix_FR}1
#sed -n '1,500p' $full_prefix_FR.informal.ref2 > ${ref_prefix_FR}2 
#sed -n '1,500p' $full_prefix_FR.informal.ref3 > ${ref_prefix_FR}3 

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

cd /projects/style_transfer/terp

python to_terp_format.py ${ref_prefix_EM}0
python to_terp_format.py ${ref_prefix_EM}1 
python to_terp_format.py ${ref_prefix_EM}2 
python to_terp_format.py ${ref_prefix_EM}3

python to_terp_format.py ${ref_prefix_FR}0 
python to_terp_format.py ${ref_prefix_FR}1 
python to_terp_format.py ${ref_prefix_FR}2 
python to_terp_format.py ${ref_prefix_FR}3

for file in "${files_EM[@]}"; do
	#sed -n '1,500p' $full_prefix_EM.$file > $prefix_EM.$file.part1
	ls $prefix_EM.$file.part1
	python to_terp_format.py $prefix_EM.$file.part1
	bin/terp -r ${ref_prefix_EM}0.terpformat -r ${ref_prefix_EM}1.terpformat -r ${ref_prefix_EM}2.terpformat -r ${ref_prefix_EM}3.terpformat -h $prefix_EM.$file.part1.terpformat > temp
	tail -1 temp	
done

for file in "${files_FR[@]}"; do
	#sed -n '1,500p' $full_prefix_FR.$file > $prefix_FR.$file.part1
	ls $prefix_FR.$file.part1
	python to_terp_format.py $prefix_FR.$file.part1
	bin/terp -r ${ref_prefix_FR}0.terpformat -r ${ref_prefix_FR}1.terpformat -r ${ref_prefix_FR}2.terpformat -r ${ref_prefix_FR}3.terpformat -h $prefix_FR.$file.part1.terpformat > temp
	tail -1 temp	
done
