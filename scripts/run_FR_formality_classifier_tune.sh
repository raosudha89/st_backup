tune_prefix=/corpora/yahoo_answers/final_data/Family_Relationships/tune/answers.Family_Relationships.sents.batch50_60.tok
tune_prefix_2=/corpora/yahoo_answers/final_data/Family_Relationships/tune2/answers.Family_Relationships.sents.batch50_60.tok

declare -a files=(
#	"$tune_prefix.org.informal"
#	"$tune_prefix.informal"
#	"$tune_prefix.formal.filtered.ref0"
#	"$tune_prefix.formal.filtered.ref1"
#	"$tune_prefix.formal.filtered.ref2"
#	"$tune_prefix.formal.filtered.ref3"
	"$tune_prefix_2.formal"
	"$tune_prefix_2.rulebased.informal"
	"$tune_prefix_2.informal.ref0"
	"$tune_prefix_2.informal.ref1"
	"$tune_prefix_2.informal.ref2"
	"$tune_prefix_2.informal.ref3"
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

