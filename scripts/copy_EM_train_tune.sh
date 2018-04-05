train_prefix=/corpora/yahoo_answers/final_data/Entertainment_Music/train/answers.entertainment_music.batches_1_30.tok
tune_prefix=/corpora/yahoo_answers/final_data/Entertainment_Music/tune/answers.Entertainment_Music.sents.batch50_60.tok
tune_prefix_2=/corpora/yahoo_answers/final_data/Entertainment_Music/tune2/answers.Entertainment_Music.sents.batch50_60.tok

declare -a files=(
	"$train_prefix.org.informal"
	"$train_prefix.informal"
	"$train_prefix.formal"
	"$train_prefix.rulebased.informal"
	"$tune_prefix.org.informal"
	"$tune_prefix.informal"
	"$tune_prefix.formal.ref0"
	"$tune_prefix.formal.ref1"
	"$tune_prefix.formal.ref2"
	"$tune_prefix.formal.ref3"
	"$tune_prefix_2.formal"
	"$tune_prefix_2.rulebased.informal"
	"$tune_prefix_2.informal.ref0"
	"$tune_prefix_2.informal.ref1"
	"$tune_prefix_2.informal.ref2"
	"$tune_prefix_2.informal.ref3"
	);

for file in "${files[@]}"; do
	#ls $file
	cp $file /projects/style_transfer/fluency_train_tune/EM/
done

