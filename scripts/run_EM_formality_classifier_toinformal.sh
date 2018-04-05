#!/usr/bin/env bash

prefix=/corpora/yahoo_answers/final_data/Entertainment_Music/test2/answers.Entertainment_Music.sents.batch040.tok
#prefix=/corpora/yahoo_answers/final_data/Entertainment_Music/test/final_human_eval/answers.Entertainment_Music.sents.batch040.tok

declare -a files=(
#		"$prefix.formal" 
#		"$prefix.informal.ref0" 
#		"$prefix.informal.ref1" 
#		"$prefix.informal.ref2" 
#		"$prefix.informal.ref3"
#		"$prefix.rulebased.informal" 
#		"$prefix.smt.informal" 
#		"$prefix.smt.onrulebased.informal" 
#		"$prefix.smt.onrulebased.selftraining10x.informal"
#		"$prefix.smt.onrulebased.selftraining.gt16editdist.informal"
#		"$prefix.smt.onrulebased.selftraining5x.gt10editdist.informal"

#		"$prefix.nmt.50K.informal" 
#		"$prefix.nmt.50K.ansemb.informal" 
#		"$prefix.nmt.50K.ansemb.copy.informal"
#		"$prefix.nmt.50K.ansemb.onrulebased.selftraining10x.informal"
#		"$prefix.nmt.50K.ansemb.copy.onrulebased.selftraining10x.informal"
#		"$prefix.nmt.50K.ansemb.copy.onrulebased.selftraining.gt16editdist.informal"
#		"$prefix.nmt.50K.ansemb.copy.onrulebased.selftraining5x.gt10editdist.informal"
		"$prefix.nmt.50K.ansemb.copy.onrulebased.selftraining5x.gt10editdist.nmtbacktranslate.informal"
		);

train_data=/projects/style_transfer/new_classifier_data/answers.entertainment_music.sents.batch.1_30.random5000.Entertainment_Music.formal.random2600.shuffled

for file in "${files[@]}"; do
        cd /projects/style_transfer/stanford-corenlp-full-2016-10-31
	sh run.sh $file
	cd /projects/style_transfer/stanford-parser-full-2016-10-31
	sh lexparser.sh $file > $file.lexparse
	cd /projects/style_transfer/
	python scripts/formality_classifier.py --dataset_file $train_data --dataset_stanford_annotations_file $train_data.conll --dataset_stanford_parse_file $train_data.lexparse --word2vec_pretrained_model data/GoogleNews-vectors-negative300.bin --case --entity --lexical --ngram --parse --POS --punctuation --readability --word2vec --dependency --test_dataset_file $file --test_dataset_stanford_annotations_file $file.conll --test_dataset_stanford_parse_file $file.lexparse --test_dataset_predictions_output_file $file.formality.predictions
	#python scripts/formality_classifier.py --dataset_file $train_data --dataset_stanford_annotations_file $train_data.conll --dataset_stanford_parse_file $train_data.lexparse --word2vec_pretrained_model data/GoogleNews-vectors-negative300.bin --case --entity --lexical --ngram --parse --POS --punctuation --readability --word2vec --dependency --test_dataset_file $file.sents --test_dataset_stanford_annotations_file $file.conll --test_dataset_stanford_parse_file $file.lexparse --test_dataset_predictions_output_file $file.formality.predictions --test_dataset_with_gold_labels_file $file
done
