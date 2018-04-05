prefix=/corpora/yahoo_answers/final_data/Entertainment_Music/test/answers.Entertainment_Music.sents.batch040
informal_file="$prefix.org.tok.informal"

declare -a files=(
#	"$prefix.tok.informal" 
#	"$prefix.filtered.smt.formal" 
#	"$prefix.filtered.selftraining10x.smt.formal" 
#	"$prefix.filtered.selftraining6x.gt10editdist.smt.formal" 
#	"$prefix.filtered.selftraining10x.smt.bleuter.formal" 
#	"$prefix.filtered.bleuter.smt.formal" 
#	"$prefix.filtered.selftraining10x.lm_all_formal_gt0.smt.formal" 
#	"$prefix.filtered.selftraining10x.lm_all_formal_gt0_moore_lewis.smt.formal" 
#	"$prefix.filtered.selftraining6x.gt10editdist.lm_All_gt_0.smt.formal" 
#	"$prefix.filtered.orginformal.smt.formal" 
#	"$prefix.model.50K_epoch14_29.77.formal" 
#	"$prefix.model.50K.gloveemb_epoch14_32.81.formal" 
#	"$prefix.filtered.smt.model.selftraining10x_epoch8_31.89.formal" 
#	"$prefix.selftraining10x.filtered.smt.model.50K.bpe_epoch8_31.89.formal"
#	"$prefix.opennmt.filtered.selftraining10x.usingnmtbacktranslate_epoch8_26.06.formal" 
#	"$prefix.selftraining10x.usingnmtbacktranslate.nmtbpe.usinglm_epoch8_25.80.formal" 
#	"$prefix.model.50K.copy_acc_50.08_ppl_36.76_e11.formal" 
#	"$prefix.model.50K.copy.ansemb_acc_51.85_ppl_28.93_e13.formal"
#	"$prefix.filtered.selftraining.gt16editdist.smt.formal"
	"$prefix.tok.formal.ref0" 
	"$prefix.tok.formal.ref1" 
	"$prefix.tok.formal.ref2" 
	"$prefix.tok.formal.ref3"
	"$prefix.tok.nmt.50K.formal"
	"$prefix.tok.nmt.50K.ansemb.formal"
	"$prefix.tok.nmt.50K.ansemb.copy.formal"
	"$prefix.tok.nmt.50K.ansemb.copy.selftraining10x.formal"
	"$prefix.tok.nmt.50K.ansemb.selftraining10x.formal"
	"$prefix.tok.nmt.50K.ansemb.copy.selftraining10x.nmtbacktranslate.formal"
	"$prefix.tok.nmt.50K.ansemb.nofix.formal"
	"$prefix.tok.nmt.50K.ansemb.copy.selftraining.gt20editdist.formal"
	"$prefix.tok.nmt.50K.ansemb.selftraining.gt20editdist.formal"
	"$prefix.tok.nmt.50K.ansemb.selftraining.gt16editdist.formal"
	"$prefix.tok.nmt.50K.ansemb.copy.selftraining.gt16editdist.formal"
	"$prefix.tok.nmt.50K.ansemb.copy.selftraining6x.gt10editdist.formal"
	"$prefix.tok.nmt.50K.ansemb.copy.selftraining6x.gt10editdist.nmtbacktranslate.formal"
	);

for file in "${files[@]}"; do
	#ls $file
	cp $file /projects/style_transfer/for_fluency/EM/to_formal
done

