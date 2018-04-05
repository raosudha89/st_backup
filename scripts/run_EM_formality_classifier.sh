#!/usr/bin/env bash

#train_data=/projects/style_transfer/new_classifier_data/answers.formality.batch1.batch2.entertainment_music.sents.batch.1_30.random5000
#train_data=/projects/style_transfer/new_classifier_data/answers.entertainment_music.sents.batch.1_30.random5000
#train_data=/projects/style_transfer/data/formality/answers.train
#train_data=/projects/style_transfer/new_classifier_data/answers.entertainment_music.sents.batch.1_30.random5000.Entertainment_Music.formal.random2600.shuffled.train

declare -a files=(
#	"$prefix.org.tok.informal" 
#	"$prefix.tok.informal" 
#	"$prefix.tok.formal.filtered.ref0" 
#	"$prefix.tok.formal.filtered.ref1" 
#	"$prefix.tok.formal.filtered.ref2" 
#	"$prefix.tok.formal.filtered.ref3" 
#	"$prefix.filtered.smt.formal" 
#	"$prefix.filtered.selftraining10x.smt.formal" 
#	"$prefix.filtered.selftraining6x.gt10editdist.smt.formal" 
#	"$prefix.filtered.selftraining10x.smt.bleuter.formal" 
#	"$prefix.filtered.bleuter.smt.formal" 
#	"$prefix.filtered.selftraining10x.lm_all_formal_gt0.smt.formal" 
#	"$prefix.filtered.selftraining10x.lm_all_formal_gt0_moore_lewis.smt.formal" 
#	"$prefix.filtered.selftraining6x.gt10editdist.lm_All_gt_0.smt.formal" 
#	"$prefix.filtered.orginformal.smt.formal" 
#	"$prefix.filtered.bleuter.smt.formal" 
#	"$prefix.model.50K_epoch14_29.77.formal" 
#		"$prefix.model.50K.gloveemb_epoch14_32.81.formal" 
#		"$prefix.selftraining6x.gt10editdist.filtered.smt.model_epoch14_31.17.formal" 
#		"$prefix.filtered.smt.model.selftraining10x_epoch8_31.89.formal" 
#		"$prefix.selftraining10x.filtered.smt.model.50K.bpe_epoch8_31.89.formal"
#		"$prefix.opennmt.filtered.selftraining10x.usingnmtbacktranslate_epoch8_26.06.formal" 
#		"$prefix.selftraining10x.usingnmtbacktranslate.nmtbpe.usinglm_epoch8_25.80.formal"
	);

prefix=/corpora/yahoo_answers/final_data/Entertainment_Music/test/answers.Entertainment_Music.sents.batch040
#prefix=/corpora/yahoo_answers/final_data/Entertainment_Music/test/final_human_eval/answers.Entertainment_Music.sents.batch040.tok

declare -a files=(
#		"$prefix.filtered.selftraining.gt16editdist.smt.formal"
#		"$prefix.tok.nmt.50K.formal"
#		"$prefix.tok.nmt.50K.ansemb.formal"
#		"$prefix.tok.nmt.50K.ansemb.copy.formal"
#		"$prefix.tok.nmt.50K.ansemb.selftraining10x.formal"
#		"$prefix.tok.nmt.50K.ansemb.copy.selftraining10x.nmtbacktranslate.formal"
#		"$prefix.tok.nmt.50K.ansemb.nofix.formal"
#		"$prefix.tok.nmt.50K.ansemb.copy.selftraining.gt20editdist.formal"
#		"$prefix.tok.nmt.50K.ansemb.selftraining10x.formal"
#		"$prefix.tok.nmt.50K.ansemb.copy.selftraining10x.formal"
#		"$prefix.tok.nmt.50K.ansemb.copy.selftraining.gt20editdist.formal"
#		"$prefix.tok.nmt.50K.ansemb.selftraining.gt20editdist.formal"
#		"$prefix.tok.nmt.50K.ansemb.copy.selftraining.gt16editdist.formal"
#		"$prefix.tok.nmt.50K.ansemb.selftraining.gt16editdist.formal"
#		"$prefix.tok.nmt.50K.ansemb.copy.selftraining.gt16editdist.formal"
#		"$prefix.tok.nmt.50K.ansemb.copy.selftraining6x.gt10editdist.formal"
#		"$prefix.tok.nmt.50K.ansemb.copy.selftraining6x.gt10editdist.nmtbacktranslate.formal"
		"/corpora/yahoo_answers/final_data/Entertainment_Music/test/final_human_eval_v2/answers.Entertainment_Music.sents.batch040.tok.formal.filtered.ref0_1_2_3.part1"
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
