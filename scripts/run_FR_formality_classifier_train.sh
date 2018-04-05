train_prefix=/corpora/yahoo_answers/final_data/Family_Relationships/train/parts/answers.Family_Relationships.sents.batches1_36.tok

declare -a files=(
#	"$train_prefix.org.informal"
#	"$train_prefix.informal"
	"$train_prefix.formal"
#	"$train_prefix.rulebased.informal"
	);

declare -a suffixes=(
	"aa"
	"ab"
	"ac"
	"ad"
	"ae"
	"af"
	"ag"
	"ah"
	"ai"
	"aj"
	"ak"
	);

train_data=/projects/style_transfer/new_classifier_data/answers.Family_Relationships.sents.batches1_36.random5000.Family_Relationships.formal.random2600.shuffled

for file in "${files[@]}"; do
        for suffix in "${suffixes[@]}"; do
		#cd /projects/style_transfer/stanford-corenlp-full-2016-10-31
		#sh run.sh $file.$suffix
		#cd /projects/style_transfer/stanford-parser-full-2016-10-31
		#sh lexparser.sh $file.$suffix > $file.$suffix.lexparse
		cd /projects/style_transfer/
		python scripts/formality_classifier.py --dataset_file $train_data --dataset_stanford_annotations_file $train_data.conll --dataset_stanford_parse_file $train_data.lexparse --word2vec_pretrained_model data/GoogleNews-vectors-negative300.bin --case --entity --lexical --ngram --parse --POS --punctuation --readability --word2vec --dependency --test_dataset_file $file.$suffix --test_dataset_stanford_annotations_file $file.$suffix.conll --test_dataset_stanford_parse_file $file.$suffix.lexparse --test_dataset_predictions_output_file $file.$suffix.formality.predictions
	done
done

