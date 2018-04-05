test_prefix=/corpora/yahoo_answers/final_data/Entertainment_Music/test/answers.Entertainment_Music.sents.batch040.tok
test_prefix_2=/corpora/yahoo_answers/final_data/Entertainment_Music/test2/answers.Entertainment_Music.sents.batch040.tok

declare -a files=(
	"$test_prefix.org.informal"
	"$test_prefix.informal"
	"$test_prefix.formal.filtered.ref0"
	"$test_prefix.formal.filtered.ref1"
	"$test_prefix.formal.filtered.ref2"
	"$test_prefix.formal.filtered.ref3"
	"$test_prefix_2.formal"
	"$test_prefix_2.rulebased.informal"
	"$test_prefix_2.informal.ref0"
	"$test_prefix_2.informal.ref1"
	"$test_prefix_2.informal.ref2"
	"$test_prefix_2.informal.ref3"
	);

train_data=/projects/style_transfer/new_classifier_data/answers.entertainment_music.sents.batch.1_30.random5000.Entertainment_Music.formal.random2600.shuffled

for file in "${files[@]}"; do
	#ls $file
	cd /projects/style_transfer/stanford-corenlp-full-2016-10-31
	sh run.sh $file
	cd /projects/style_transfer/stanford-parser-full-2016-10-31
	sh lexparser.sh $file > $file.lexparse
	cd /projects/style_transfer/
	python scripts/formality_classifier.py --dataset_file $train_data --dataset_stanford_annotations_file $train_data.conll --dataset_stanford_parse_file $train_data.lexparse --word2vec_pretrained_model data/GoogleNews-vectors-negative300.bin --case --entity --lexical --ngram --parse --POS --punctuation --readability --word2vec --dependency --test_dataset_file $file --test_dataset_stanford_annotations_file $file.conll --test_dataset_stanford_parse_file $file.lexparse --test_dataset_predictions_output_file $file.formality.predictions
done

