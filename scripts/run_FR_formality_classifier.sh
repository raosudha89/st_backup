#!/usr/bin/env bash

prefix=/corpora/yahoo_answers/final_data/Family_Relationships/test/answers.Family_Relationships.sents.batch0040
declare -a files=(
#		"$prefix.filtered.selftraining.gt20editdist.smt.formal"
#		"$prefix.tok.nmt.50K.formal"
#		"$prefix.tok.nmt.50K.ansemb.formal"
#		"$prefix.tok.nmt.50K.ansemb.copy.formal"
#		"$prefix.tok.nmt.50K.ansemb.selftraining10x.formal"
#		"$prefix.tok.nmt.50K.ansemb.copy.selftraining10x.formal"
#		"$prefix.tok.nmt.50K.ansemb.copy.selftraining10x.nmtbacktranslate.formal"
#		"$prefix.tok.nmt.50K.ansemb.copy.selftraining.gt20editdist.formal"
#		"$prefix.tok.nmt.50K.ansemb.selftraining.gt20editdist.formal"
#		"$prefix.tok.nmt.50K.ansemb.copy.selftraining10x.gt10editdist.formal"
#		"$prefix.tok.nmt.50K.ansemb.copy.selftraining10x.gt10editdist.nmtbacktranslate.formal"
		"/corpora/yahoo_answers/final_data/Family_Relationships/test/final_human_eval_v2/answers.Family_Relationships.sents.batch0040.filtered.tok.formal.ref0_1_2_3.part1"
		);

train_data=/projects/style_transfer/new_classifier_data/answers.Family_Relationships.sents.batches1_36.random5000.Family_Relationships.formal.random2600.shuffled

for file in "${files[@]}"; do
        cd /projects/style_transfer/stanford-corenlp-full-2016-10-31
	sh run.sh $file
	cd /projects/style_transfer/stanford-parser-full-2016-10-31
	sh lexparser.sh $file > $file.lexparse
	cd /projects/style_transfer/
	python scripts/formality_classifier.py --dataset_file $train_data --dataset_stanford_annotations_file $train_data.conll --dataset_stanford_parse_file $train_data.lexparse --word2vec_pretrained_model data/GoogleNews-vectors-negative300.bin --case --entity --lexical --ngram --parse --POS --punctuation --readability --word2vec --dependency --test_dataset_file $file --test_dataset_stanford_annotations_file $file.conll --test_dataset_stanford_parse_file $file.lexparse --test_dataset_predictions_output_file $file.formality.predictions
done

