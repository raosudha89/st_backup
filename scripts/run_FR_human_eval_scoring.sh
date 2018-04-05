declare -a files=("/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval/answers.Family_Relationships.sents.batch0040.org.tok.informal" 
		"/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval/answers.Family_Relationships.sents.batch0040.tok.informal" 
		"/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval/answers.Family_Relationships.sents.batch0040.filtered.selftraining10x.gt0editdit.lm_All_gt_0.smt.formal" 
		"/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval/answers.Family_Relationships.sents.batch0040.filtered.model.50K_epoch13_13.89.formal" 
		"/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval/answers.Family_Relationships.sents.batch0040.filtered.smt.Family_Relationships.model.selftraining10x.usingnmtbacktranslate.nmtbpe.usinglm_epoch5_15.21.formal" 
		"/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval/answers.Family_Relationships.sents.batch0040.filtered.tok.formal.ref0_1_2_3" 
		); 

#train_data=/projects/style_transfer/new_classifier_data/answers.Family_Relationships.sents.batches1_36.random5000.Family_Relationships.formal.random2600.shuffled
#RUN FORMALITY CLASSIFIER
#for file in "${files[@]}"; do
#	cd /projects/style_transfer/stanford-corenlp-full-2016-10-31
#	sh run.sh $file
#	cd /projects/style_transfer/stanford-parser-full-2016-10-31
#	sh lexparser.sh $file > $file.lexparse
#	cd /projects/style_transfer/
#	python scripts/formality_classifier.py --dataset_file $train_data --dataset_stanford_annotations_file $train_data.conll --dataset_stanford_parse_file $train_data.lexparse --word2vec_pretrained_model data/GoogleNews-vectors-negative300.bin --case --entity --lexical --ngram --parse --POS --punctuation --readability --word2vec --dependency --test_dataset_file $file --test_dataset_stanford_annotations_file $file.conll --test_dataset_stanford_parse_file $file.lexparse --test_dataset_predictions_output_file $file.formality.predictions
#done

fluency_pred=/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval/answers.Family_Relationships.sents.batch0040.fluency.predictions
fluency_human=/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval/answers.Family_Relationships.sents.batch0040.fluency.human
formality_pred=/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval/answers.Family_Relationships.sents.batch0040.formality.predictions
formality_human=/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval/answers.Family_Relationships.sents.batch0040.formality.human
meaning_pred=/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval/answers.Family_Relationships.sents.batch0040.meaning.predictions
meaning_human=/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval/answers.Family_Relationships.sents.batch0040.meaning.human

rm $fluency_pred
rm $fluency_human
rm $formality_pred
rm $formality_human
rm $meaning_pred
rm $meaning_human

source_dir=/corpora/yahoo_answers/final_data/Family_Relationships/test

for sourcefile in "${files[@]}"; do
	file=$sourcefile.part1
	sed -n '1,500p' $source_dir/$(basename $sourcefile).json.ord > $file.fluency.predictions 	
	echo $file
	echo "Fluency Heilman"
	python scripts/calculate_avg_formality.py $file.fluency.predictions
	echo "Fluency Human"
	python scripts/calculate_avg_formality.py $file.fluency.human
	echo "Fluency correlation"
	python scripts/calculate_spearmanr.py $file.fluency.predictions $file.fluency.human	
	cat $file.fluency.predictions >> $fluency_pred 
	cat $file.fluency.human >> $fluency_human	

	echo "Formality Classifier"
	sed -n '1,500p' $source_dir/$(basename $sourcefile).formality.predictions > $file.formality.predictions 
	python scripts/calculate_avg_formality.py $file.formality.predictions
	echo "Formality Human"
	python scripts/calculate_avg_formality.py $file.formality.human
	echo "Formality correlation"
	python scripts/calculate_spearmanr.py $file.formality.predictions  $file.formality.human
	cat $file.formality.predictions >> $formality_pred 
	cat $file.formality.human >> $formality_human	

	if [ ! -f $file ];
	then
		continue
	fi
	sed -n '1,500p' $source_dir/$(basename $sourcefile).meaning.predictions > $file.meaning.predictions
	echo "Meaning CNN"
	python scripts/calculate_avg_formality.py $file.meaning.predictions
	echo "Meaning Human"
	python scripts/calculate_avg_formality.py $file.meaning.human
	echo "Meaning correlation"
        python scripts/calculate_spearmanr.py $file.meaning.predictions $file.meaning.human
	cat $file.meaning.predictions >> $meaning_pred 
	cat $file.meaning.human >> $meaning_human	
done

echo "Fluency correlation"
python scripts/calculate_spearmanr.py $fluency_pred $fluency_human

echo "Formality correlation"
python scripts/calculate_spearmanr.py $formality_pred $formality_human

echo "Meaning correlation"
python scripts/calculate_spearmanr.py $meaning_pred $meaning_human

